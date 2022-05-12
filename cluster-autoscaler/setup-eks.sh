#Needs files from https://github.com/narmitag/eks/tree/main/cluster-autoscaler

export AWS_REGION=us-east-1
export CLUSTER_NAME=ca-cluster
export ACCOUNT_ID=$(aws sts get-caller-identity --query "Account" --output text)

eksctl create cluster -f ca-cluster.yaml

aws eks update-kubeconfig --name ca-cluster --region=us-east-1


aws autoscaling describe-auto-scaling-groups --query "AutoScalingGroups[? Tags[? (Key=='eks:cluster-name') && Value=='$CLUSTER_NAME']].AutoScalingGroupName" --output text > asg.txt

for x in $(cat asg.txt); do aws autoscaling update-auto-scaling-group --auto-scaling-group-name  $x  --min-size 1 --desired-capacity 1 --max-size 2; done

eksctl utils associate-iam-oidc-provider \
    --cluster $CLUSTER_NAME \
    --approve


aws iam create-policy   \
  --policy-name ${CLUSTER_NAME}-k8s-asg-policy \
  --policy-document file://k8s-asg-policy.json

eksctl create iamserviceaccount \
  --name cluster-autoscaler \
  --namespace kube-system \
  --cluster $CLUSTER_NAME \
  --attach-policy-arn "arn:aws:iam::${ACCOUNT_ID}:policy/${CLUSTER_NAME}-k8s-asg-policy" \
  --approve \
  --override-existing-serviceaccounts

kubectl -n kube-system describe sa cluster-autoscaler

envsubst < cluster-autoscaler-autodiscover.yaml | kubectl apply -f -

kubectl -n kube-system annotate deployment.apps/cluster-autoscaler  cluster-autoscaler.kubernetes.io/safe-to-evict="false"


export AUTOSCALER_VERSION=1.22.2
kubectl -n kube-system \
    set image deployment.apps/cluster-autoscaler \
    cluster-autoscaler=us.gcr.io/k8s-artifacts-prod/autoscaling/cluster-autoscaler:v${AUTOSCALER_VERSION}
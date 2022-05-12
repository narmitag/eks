curl -L --remote-name-all https://github.com/cilium/cilium-cli/releases/latest/download/cilium-linux-amd64.tar.gz{,.sha256sum}
sha256sum --check cilium-linux-amd64.tar.gz.sha256sum
sudo tar xzvfC cilium-linux-amd64.tar.gz /usr/local/bin
rm cilium-linux-amd64.tar.gz{,.sha256sum}


export HUBBLE_VERSION=$(curl -s https://raw.githubusercontent.com/cilium/hubble/master/stable.txt)
curl -L --remote-name-all https://github.com/cilium/hubble/releases/download/$HUBBLE_VERSION/hubble-linux-amd64.tar.gz{,.sha256sum}
sha256sum --check hubble-linux-amd64.tar.gz.sha256sum
sudo tar xzvfC hubble-linux-amd64.tar.gz /usr/local/bin
rm hubble-linux-amd64.tar.gz{,.sha256sum}




export AWS_REGION=us-east-1
export AWS_DEFAULT_REGION=us-east-1
export CLUSTER_NAME=cilium-cluster
export ACCOUNT_ID=$(aws sts get-caller-identity --query "Account" --output text)

eksctl create cluster -f - << EOF
---
apiVersion: eksctl.io/v1alpha5
kind: ClusterConfig

metadata:
  name: ${CLUSTER_NAME}
  region: ${AWS_DEFAULT_REGION}
  version: "1.22"

availabilityZones: ["${AWS_DEFAULT_REGION}a","${AWS_DEFAULT_REGION}b"]
managedNodeGroups:
  - instanceType: t3.medium
    name: ${CLUSTER_NAME}-ng
    desiredCapacity: 2
    minSize: 1
    maxSize: 2

EOF

aws eks update-kubeconfig --name ${CLUSTER_NAME} --region=${AWS_DEFAULT_REGION}

helm repo add cilium https://helm.cilium.io/

helm install cilium cilium/cilium --version 1.11.3 \
  --namespace kube-system \
  --set cni.chainingMode=aws-cni \
  --set enableIPv4Masquerade=false \
  --set tunnel=disabled \
  --set hubble.listenAddress=":4244" \
  --set hubble.relay.enabled=true \
  --set hubble.ui.enabled=true


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

envsubst < cluster-autoscaler-autodiscover.yaml | kubectl apply -f -

kubectl -n kube-system annotate deployment.apps/cluster-autoscaler  cluster-autoscaler.kubernetes.io/safe-to-evict="false"

export AUTOSCALER_VERSION=1.21.2
kubectl -n kube-system \
    set image deployment.apps/cluster-autoscaler \
    cluster-autoscaler=us.gcr.io/k8s-artifacts-prod/autoscaling/cluster-autoscaler:v${AUTOSCALER_VERSION}


#NGINX
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.1.1/deploy/static/provider/aws/deploy.yaml


#linkerd install | kubectl apply -f -


 kubectl port-forward -n $CILIUM_NAMESPACE svc/hubble-ui --address 0.0.0.0 --address :: 12000:80
 http://localhost:12000/ 


kubectl port-forward -n $CILIUM_NAMESPACE svc/hubble-relay --address 0.0.0.0 --address :: 4245:80

hubble --server localhost:4245 status
hubble --server localhost:4245 observe

https://cilium.io/blog/2018/09/19/kubernetes-network-policies
aws efs describe-file-systems --query "FileSystems[*].FileSystemId" --output text

curl -o storageclass.yaml https://raw.githubusercontent.com/kubernetes-sigs/aws-efs-csi-driver/master/examples/kubernetes/dynamic_provisioning/specs/storageclass.yaml

#edit file and update fileSystemId
fs-0e003d54880c3cec9

kubectl apply -f storageclass.yaml


curl -o pod.yaml https://raw.githubusercontent.com/kubernetes-sigs/aws-efs-csi-driver/master/examples/kubernetes/dynamic_provisioning/specs/pod.yaml


kubectl exec efs-app -- bash -c "cat data/out"


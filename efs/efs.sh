Assumes a cluster exists 



export CLUSTER=forgerock-test

vpc_id=$(aws eks describe-cluster \
    --name $CLUSTER \
    --query "cluster.resourcesVpcConfig.vpcId" \
    --output text)

cidr_range=$(aws ec2 describe-vpcs \
    --vpc-ids $vpc_id \
    --query "Vpcs[].CidrBlock" \
    --output text)

security_group_id=$(aws ec2 create-security-group \
    --group-name MyEfsSecurityGroup \
    --description "My EFS security group" \
    --vpc-id $vpc_id \
    --output text)

aws ec2 authorize-security-group-ingress \
    --group-id $security_group_id \
    --protocol tcp \
    --port 2049 \
    --cidr $cidr_range


file_system_id=$(aws efs create-file-system \
    --region eu-west-2 \
    --performance-mode generalPurpose \
    --query 'FileSystemId' \
    --output text)

aws ec2 describe-subnets \
    --filters "Name=vpc-id,Values=$vpc_id" \
    --query 'Subnets[*].{SubnetId: SubnetId,AvailabilityZone: AvailabilityZone,CidrBlock: CidrBlock}' \
    --output table

subnets=$(aws ec2 describe-subnets \
    --filters "Name=vpc-id,Values=$vpc_id" \
    --query 'Subnets[*].{SubnetId: SubnetId}' \
    --output text)


echo $subnets > subnets.txt
#Repeat for each subent

aws efs create-mount-target \
    --file-system-id $file_system_id \
    --subnet-id subnet-EXAMPLEe2ba886490 \
    --security-groups $security_group_id

for s in $(cat subnets.txt); do aws efs create-mount-target --file-system-id $file_system_id --subnet-id $s  --security-groups $security_group_id;done
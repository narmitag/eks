export MY_AWS_ACCOUNT=$(aws sts get-caller-identity | jq -r ".Account")

export MY_AWS_REGION=$(aws configure get default.region)

docker pull nginx

docker tag nginx:latest $MY_AWS_ACCOUNT.dkr.ecr.$MY_AWS_REGION.amazonaws.com/nginx:latest

aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin $MY_AWS_ACCOUNT.dkr.ecr.$MY_AWS_REGION.amazonaws.com

docker push $MY_AWS_ACCOUNT.dkr.ecr.$MY_AWS_REGION.amazonaws.com/nginx:latest
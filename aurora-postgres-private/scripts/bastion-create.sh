cd "$PROJECT_DIR/terraform"
JSON=$(terraform output -json)
# echo "$JSON"

AMI_ID=$(echo "$JSON" | jq --raw-output '.latest_amazon_linux_ami_id.value')
log AMI_ID $AMI_ID

# AMI_ID=$(aws ec2 describe-images \
#         --region $AWS_REGION \
#         --owners amazon \
#         --query "reverse(sort_by(Images, &CreationDate))[:1].ImageId" \
#         --filter 'Name=name,Values=amzn2-ami-kernel-5*-x86_64-gp2' \
#         --output text)
# log AMI_ID $AMI_ID

SECURITY_GROUP_ID=$(echo "$JSON" | jq --raw-output '.ec2_security_group_id.value')
log SECURITY_GROUP_ID $SECURITY_GROUP_ID

# WARN : must be a public subnet
SUBNET_ID=$(echo "$JSON" | jq --raw-output '.ec2_subnet_id.value')
log SUBNET_ID $SUBNET_ID

# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/ec2/run-instances.html
aws ec2 run-instances \
    --image-id $AMI_ID \
    --count 1 \
    --instance-type t2.micro \
    --security-group-ids $SECURITY_GROUP_ID \
    --subnet-id $SUBNET_ID \
    --iam-instance-profile "Name=$PROJECT_NAME-ec2-profile" \
    --associate-public-ip-address \
    --key-name $PROJECT_NAME \
    --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$PROJECT_NAME-bastion}]" \
    --query 'Instances[0].InstanceId' \
    --region $AWS_REGION \
    --output text

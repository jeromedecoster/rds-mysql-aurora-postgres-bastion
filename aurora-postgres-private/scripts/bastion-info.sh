EC2_PUBLIC_DNS=$(aws ec2 describe-instances \
    --filters Name=instance-state-name,Values=running Name=tag:Name,Values=$PROJECT_NAME-bastion \
    --query 'Reservations[0].Instances[0].PublicDnsName' \
    --region $AWS_REGION \
    --output text)
log EC2_PUBLIC_DNS $EC2_PUBLIC_DNS

cd "$PROJECT_DIR/terraform"
HOST=$(terraform output -raw db_instance_endpoint)
log HOST $HOST

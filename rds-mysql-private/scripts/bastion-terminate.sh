
INSTANCE_ID=$(aws ec2 describe-instances \
    --filters Name=instance-state-name,Values=running Name=tag:Name,Values=$PROJECT_NAME-bastion \
    --query 'Reservations[].Instances[].InstanceId' \
    --region $AWS_REGION \
    --output text)
log INSTANCE_ID $INSTANCE_ID

if [[ -n "$INSTANCE_ID" ]];
then
    aws ec2 terminate-instances \
        --instance-ids $INSTANCE_ID \
        --query 'TerminatingInstances[0].InstanceId' \
        --region $AWS_REGION \
        --output text
fi

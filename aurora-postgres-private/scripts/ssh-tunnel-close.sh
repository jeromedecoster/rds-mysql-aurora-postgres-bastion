EC2_PUBLIC_DNS=$(aws ec2 describe-instances \
    --filters Name=instance-state-name,Values=running Name=tag:Name,Values=aurora-postgres-private-bastion \
    --query 'Reservations[].Instances[].PublicDnsName' \
    --region $AWS_REGION \
    --output text)
log EC2_PUBLIC_DNS $EC2_PUBLIC_DNS

# https://stackoverflow.com/a/19069428
TUNNEL_ID=$(ps aux | grep ssh | grep $EC2_PUBLIC_DNS | head -n 1 | tr -s ' ' | cut -d ' ' -f 2)
log TUNNEL_ID $TUNNEL_ID

if [[ -n "$TUNNEL_ID" ]];
then
    info kill pid $TUNNEL_ID
    kill -9 $TUNNEL_ID
fi

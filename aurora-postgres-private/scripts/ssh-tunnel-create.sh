cd "$PROJECT_DIR/terraform"
JSON=$(terraform output -json)
# echo "$JSON"

log PROJECT_NAME $PROJECT_NAME

KEY_FILE=$PROJECT_NAME.pem
log KEY_FILE $KEY_FILE

HOST=$(echo "$JSON" | jq --raw-output '.db_instance_endpoint.value')
log HOST $HOST

EC2_PUBLIC_DNS=$(aws ec2 describe-instances \
    --filters Name=instance-state-name,Values=running Name=tag:Name,Values=$PROJECT_NAME-bastion \
    --query 'Reservations[].Instances[].PublicDnsName' \
    --output text)
log EC2_PUBLIC_DNS $EC2_PUBLIC_DNS

# SSH add key to known_hosts to not be prompt by :
# 'key fingerprint ... Are you sure you want to continue connecting (yes/no) ?'
# https://www.techrepublic.com/article/how-to-easily-add-an-ssh-fingerprint-to-your-knownhosts-file-in-linux/
# https://superuser.com/a/1533678
if [[ -z $(grep $EC2_PUBLIC_DNS < ~/.ssh/known_hosts) ]];
then
    info SSH_KEYSCAN add $EC2_PUBLIC_DNS into "~/.ssh/known_hosts"
    # option -t type : Specify the type of the key to fetch from the scanned hosts.
    # The possible values are “dsa”, “ecdsa”, “ed25519”, or “rsa”.  Multiple values may be specified by
    # separating them with commas.  The default is to fetch “rsa”, “ecdsa”, and “ed25519” keys.

    # WARN : if you don't specify a type (ignore option -t) 3 lines will be added in ~/.ssh/known_hosts
    # 3 lines like :
    # $EC2_PUBLIC_DNS ssh-rsa AAAAB3N....
    # $EC2_PUBLIC_DNS ecdsa-sha2-nistp256 AAAAE2VjZ....
    # $EC2_PUBLIC_DNS ssh-ed25519 AAAAC3Nz....
    # So, if you already know the type of you SSH Key you want to add (and it's probably the case),
    # it's cleaner to specify it here 
    ssh-keyscan -t rsa $EC2_PUBLIC_DNS >> ~/.ssh/known_hosts
fi

# https://stackoverflow.com/a/19069428
TUNNEL_ID=$(ps aux | grep ssh | grep $EC2_PUBLIC_DNS | tr -s ' ' | cut -d ' ' -f 2)
log TUNNEL_ID $TUNNEL_ID

if [[ -z "$TUNNEL_ID" ]];
then
    info SSH create SSH tunnel
    # create SSH tunnel
    # option -i <identity_file> 
    #   ➜ Selects a file from which the identity (private key) for public 
    #      key authentication is read.  The default is ~/.ssh/id_dsa, ~/.ssh/id_ecdsa, 
    #      ~/.ssh/id_ecdsa_sk, ~/.ssh/id_ed25519, ~/.ssh/id_ed25519_sk and ~/.ssh/id_rsa.
    #
    # option -f 
    #   ➜ Requests ssh to go to background just before command execution. This is useful if ssh
    #      is going to ask for passwords or passphrases, but the user wants it in the background.
    #
    # option -N 
    #   ➜ Do not execute a remote command.  This is useful for just forwarding ports.   
    #
    # option -L [bind_address:]port:host:hostport 
    #   ➜ Specifies that connections to the given TCP port on the local (client) host are to
    #      be forwarded to the given host and port on the remote side.
    #
    # option -v
    #   ➜ Verbose mode. Causes ssh to print debugging messages about its progress.
    #      Multiple -v options increase the verbosity. The maximum is 3.
    ssh -i "$KEY_FILE" -f -N -L 5433:$HOST:5432 ec2-user@$EC2_PUBLIC_DNS -v
fi

info SSH_TUNNEL "if success, execute in another terminal window :" "psql postgresql://$POSTGRES_USERNAME:$POSTGRES_PASSWORD@127.0.0.1:5433/postgres?sslmode=require"

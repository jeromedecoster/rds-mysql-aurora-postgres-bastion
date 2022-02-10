ec2-connect() {
    cd "$PROJECT_DIR/terraform"
    JSON=$(terraform output -json)

    log PROJECT_NAME $PROJECT_NAME

    EC2_PUBLIC_DNS=$(echo "$JSON" | jq --raw-output '.ec2_public_dns.value')
    log EC2_PUBLIC_DNS $EC2_PUBLIC_DNS

    HOST=$(echo "$JSON" | jq --raw-output '.db_instance_address.value')
    log HOST $HOST

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

    info SSH "if success, execute on the instance :" "mysql --user=$MYSQL_USERNAME --password=$MYSQL_PASSWORD --host=$HOST"

    # ec2-user@.. because it's Amazon Linux 2 AMI
    #   ubuntu@.. if it was Ubuntu Server
    ssh -i "$PROJECT_NAME.pem" ec2-user@$EC2_PUBLIC_DNS
}

ec2-connect
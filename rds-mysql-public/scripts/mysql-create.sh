mysql-create() {
    log START $(date "+%Y-%d-%m %H:%M:%S")
    START=$SECONDS

    cd "$PROJECT_DIR/terraform"
    HOST=$(terraform output --raw db_instance_address)
    log HOST $HOST

    log MYSQL_USERNAME $MYSQL_USERNAME
    log MYSQL_PASSWORD $MYSQL_PASSWORD

    cd "$PROJECT_DIR/sql"
    mysql --user=$MYSQL_USERNAME --password=$MYSQL_PASSWORD --host=$HOST < create.sql

    log END $(date "+%Y-%d-%m %H:%M:%S")
    info DURATION $(($SECONDS - $START)) seconds
}

mysql-create
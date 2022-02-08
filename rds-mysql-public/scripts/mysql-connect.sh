mysql-connect() {
    cd "$PROJECT_DIR/terraform"
    HOST=$(terraform output --raw db_instance_address)
    log HOST $HOST

    log MYSQL_USERNAME $MYSQL_USERNAME
    log MYSQL_PASSWORD $MYSQL_PASSWORD

    mysql --user=$MYSQL_USERNAME --password=$MYSQL_PASSWORD --host=$HOST

    # select * from rds.authors;
}

mysql-connect
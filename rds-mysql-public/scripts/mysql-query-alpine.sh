mysql-query-alpine() {
    log START $(date "+%Y-%d-%m %H:%M:%S")
    START=$SECONDS

    cd "$PROJECT_DIR/terraform"
    HOST=$(terraform output --raw db_instance_address)
    log HOST $HOST

    log MYSQL_USERNAME $MYSQL_USERNAME
    log MYSQL_PASSWORD $MYSQL_PASSWORD

    cd "$PROJECT_DIR/sql"
    info RUN docker run ... alpine entrypoint.sh
    docker run \
        --interactive \
        --tty \
        --rm \
        --volume $(pwd):/var/task \
        --workdir /var/task \
        --env MYSQL_USERNAME=$MYSQL_USERNAME \
        --env MYSQL_PASSWORD=$MYSQL_PASSWORD \
        --env HOST=$HOST \
        --entrypoint=/bin/sh \
        alpine entrypoint.sh

    log END $(date "+%Y-%d-%m %H:%M:%S")
    info DURATION $(($SECONDS - $START)) seconds
}

mysql-query-alpine
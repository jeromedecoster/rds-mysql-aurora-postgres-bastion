validate() {
    log START $(date "+%Y-%d-%m %H:%M:%S")
    START=$SECONDS

    cd "$PROJECT_DIR/terraform"
    terraform fmt -recursive
    terraform validate

    log END $(date "+%Y-%d-%m %H:%M:%S")
    info DURATION $(($SECONDS - $START)) seconds
}

validate

apply() {
    log START $(date "+%Y-%d-%m %H:%M:%S")
    START=$SECONDS

    log PROJECT_NAME $PROJECT_NAME
    
    cd "$PROJECT_DIR/terraform"
    terraform plan

    log END $(date "+%Y-%d-%m %H:%M:%S")
    info DURATION $(($SECONDS - $START)) seconds
}

apply

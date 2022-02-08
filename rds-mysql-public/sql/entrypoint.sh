# $1 uppercase background white then $2
log() { echo -e "\e[30;47m ${1} \e[0m ${2}"; }

log MYSQL_USERNAME $MYSQL_USERNAME
log MYSQL_PASSWORD $MYSQL_PASSWORD
log HOST $HOST

apk add mysql mysql-client

mysql --user=$MYSQL_USERNAME --password=$MYSQL_PASSWORD --host=$HOST --execute="source query.sql"

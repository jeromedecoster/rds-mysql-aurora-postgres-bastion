.SILENT:

help:
	{ grep --extended-regexp '^[a-zA-Z0-9._-]+:.*#[[:space:]].*$$' $(MAKEFILE_LIST) || true; } \
	| awk 'BEGIN { FS = ":.*#[[:space:]]*" } { printf "\033[1;32m%-20s\033[0m%s\n", $$1, $$2 }'

setup: # terraform setup
	./make.sh setup

validate: # terraform format + validation
	./make.sh validate

apply: # terraform plan + apply (deploy)
	./make.sh apply

mysql-create: # create database + tables + insert values
	./make.sh mysql-create

mysql-connect: # connect to rds 
	./make.sh mysql-connect

mysql-query-alpine: # query values from 'apline' docker image
	./make.sh mysql-query-alpine

mysql-query-client: # query values from 'arey/mysql-client' docker image
	./make.sh mysql-query-client

destroy: # destroy all resources
	./make.sh destroy

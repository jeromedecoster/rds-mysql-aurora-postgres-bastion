.SILENT:

help:
	{ grep --extended-regexp '^[a-zA-Z0-9._-]+:.*#[[:space:]].*$$' $(MAKEFILE_LIST) || true; } \
	| awk 'BEGIN { FS = ":.*#[[:space:]]*" } { printf "\033[1;32m%-19s\033[0m%s\n", $$1, $$2 }'

setup: # terraform setup
	./make.sh setup

validate: # terraform format + validation
	./make.sh validate

# plan: # terraform plan (to stdout)
# 	./make.sh plan

apply: # terraform plan + apply (deploy)
	./make.sh apply

ec2-connect: # ssh connect to the ec2 instance  
	./make.sh ec2-connect

bastion-create: # create an ec2 bastion host
	./make.sh bastion-create

bastion-info: # get bastion + database endpoints
	./make.sh bastion-info

bastion-terminate: # close the ec2 bastion host
	./make.sh bastion-terminate

ssh-tunnel-create: # create a ssh tunnel
	./make.sh ssh-tunnel-create

ssh-tunnel-close: # close the ssh tunnel
	./make.sh ssh-tunnel-close

destroy: # destroy all resources
	./make.sh destroy

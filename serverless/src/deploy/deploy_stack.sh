#!/bin/bash

deploy_stack() {
	print_title "Deploying a stack"

	STACK_NAME=$1
	BUCKET_NAME=$2
	TEMPLATE_URL="https://${BUCKET_NAME}.s3.${AWS_REGION}.amazonaws.com/cloudformation/main.yaml"

	aws cloudformation describe-stacks --stack-name ${STACK_NAME} > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		printf "${YELLOW}Stack already exists: ${STACK_NAME}${DEFAULT}\n\n"
		printf "Do you want to update the stack? [y/n]: "
		read -r UPDATE_STACK
		printf "\n"

		if [ "${UPDATE_STACK}" != "y" ]; then
			sleep 1
			return 1
		fi

		printf "Updating a stack: ${STACK_NAME}...\n\n"

		aws cloudformation update-stack \
			--stack-name ${STACK_NAME} \
			--template-url ${TEMPLATE_URL} > /dev/null 2>&1

		aws cloudformation wait stack-create-complete --stack-name ${STACK_NAME}
		
		printf "Stack updated: ${STACK_NAME}\n\n"
	else
		printf "Creating a stack: ${STACK_NAME}...\n\n"

		aws cloudformation create-stack \
			--stack-name ${STACK_NAME} \
			--template-url ${TEMPLATE_URL} > /dev/null 2>&1

		aws cloudformation wait stack-create-complete --stack-name ${STACK_NAME}

		printf "Stack created: ${STACK_NAME}\n\n"
	fi

	sleep 1
	return 0
}
#!/bin/bash

delete_stack() {
	print_title "Deleting a stack"

	STACK_NAME=$1

	printf "Deleting a stack: ${STACK_NAME}...\n\n"

	aws cloudformation describe-stacks --stack-name ${STACK_NAME} > /dev/null 2>&1
	if [ $? -ne 0 ]; then
		printf "${YELLOW}Stack does not exist: ${STACK_NAME}${DEFAULT}\n\n"
		sleep 1
		return 1
	fi

	empty_buckets() {
		local STACK_NAME=$1

		BUCKETS=$(
			aws cloudformation describe-stack-resources \
			--stack-name ${STACK_NAME} \
			--query "StackResources[?ResourceType == 'AWS::S3::Bucket'].PhysicalResourceId" \
			--output text
		)

		if [ -n "${BUCKETS}" ]; then
			for BUCKET in ${BUCKETS}; do
				aws s3 rm s3://${BUCKET} --recursive
			done

			printf "\n"
		fi

		local NESTED_STACKS=$(
			aws cloudformation describe-stack-resources \
			--stack-name ${STACK_NAME} \
			--query "StackResources[?ResourceType == 'AWS::CloudFormation::Stack'].PhysicalResourceId" \
			--output text
		)

		for NESTED_STACK in ${NESTED_STACKS}; do
			empty_buckets ${NESTED_STACK}
		done
	}

	empty_buckets ${STACK_NAME}

	aws cloudformation delete-stack --stack-name ${STACK_NAME}

	printf "Stack deleted: ${STACK_NAME}\n\n"

	sleep 1
}
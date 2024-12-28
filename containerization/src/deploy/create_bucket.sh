#!/bin/bash

create_bucket() {
	print_title "Creating a bucket"

	BUCKET_NAME=$1

	printf "Creating a bucket: ${BUCKET_NAME}...\n\n"

	aws s3api head-bucket --bucket ${BUCKET_NAME} > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		printf "${YELLOW}Bucket already exists:\n${UNDERLINE}https://${BUCKET_NAME}.s3.${AWS_REGION}.amazonaws.com${DEFAULT}\n\n"
		sleep 1
		return
	fi

	aws s3api create-bucket --bucket ${BUCKET_NAME} > /dev/null 2>&1
	
	printf "Bucket created:\nhttps://${BUCKET_NAME}.s3.${AWS_REGION}.amazonaws.com\n\n"

	sleep 1
}
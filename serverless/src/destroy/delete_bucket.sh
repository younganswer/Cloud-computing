#!/bin/bash

delete_bucket() {
	print_title "Deleting a bucket"

	BUCKET_NAME=$1

	aws s3api head-bucket --bucket ${BUCKET_NAME} > /dev/null 2>&1
	if [ $? -ne 0 ]; then
		printf "${YELLOW}Bucket does not exist: ${BUCKET_NAME}${DEFAULT}\n\n"
		sleep 1
		return 1
	fi

	aws s3 rb s3://${BUCKET_NAME} --force

	printf "\n"

	sleep 1
}
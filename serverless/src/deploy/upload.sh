#!/bin/bash

upload() {
	FILE_PATH="${PATH_DEPLOY}"/deployment/$1
	BUCKET_NAME=$2
	
	print_title "Uploading $1 to ${BUCKET_NAME}"

	aws s3api head-bucket --bucket ${BUCKET_NAME} > /dev/null 2>&1
	if [ $? -ne 0 ]; then
		printf "${RED}Error: Bucket does not exist: ${BUCKET_NAME}${DEFAULT}\n\n"
		sleep 1
		return 1
	fi

	aws s3 cp "${FILE_PATH}" s3://${BUCKET_NAME}/$1 --recursive

	printf "\n"

	sleep 1
}
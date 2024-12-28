#!/bin/bash

push_image() {
	REPOSITORY_URL="${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
	REPOSITORY_NAMESPACE=$1
	REPOSITORY_NAME=$2

	print_title "Pushing ${REPOSITORY_NAME} image to ${REPOSITORY_NAMESPACE} repository"

	aws ecr describe-repositories --repository-names ${REPOSITORY_NAMESPACE}/${REPOSITORY_NAME} > /dev/null 2>&1
	if [ $? -ne 0 ]; then
		printf "${RED}Error: Repository does not exist: ${REPOSITORY_NAMESPACE}/${REPOSITORY_NAME}${DEFAULT}\n\n"
		sleep 1
		return 1
	fi

	aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${REPOSITORY_URL}

	docker buildx build --platform linux/amd64 -t ${REPOSITORY_NAME} deployment/container/${REPOSITORY_NAME} > /dev/null 2>&1
	if [ $? -ne 0 ]; then
		printf "${RED}Error: Build image failed: ${REPOSITORY_NAME}${DEFAULT}\n\n"
		sleep 1
		return 1
	fi

	docker tag ${REPOSITORY_NAME}:latest ${REPOSITORY_URL}/${REPOSITORY_NAMESPACE}/${REPOSITORY_NAME}:latest
	if [ $? -ne 0 ]; then
		printf "${RED}Error: Tag image failed: ${REPOSITORY_NAME}${DEFAULT}\n\n"
		sleep 1
		return 1
	fi
		
	printf "Image ${REPOSITORY_NAME} built successfully\n"

	docker push ${REPOSITORY_URL}/${REPOSITORY_NAMESPACE}/${REPOSITORY_NAME}:latest
	if [ $? -ne 0 ]; then
		printf "${RED}Error: Push image failed${DEFAULT}\n\n"
		sleep 1
		return 1
	fi

	printf "\nImage pushed successfully\n\n"

	sleep 1
}
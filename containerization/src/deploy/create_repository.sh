#!/bin/bash

create_repository() {
	print_title "Creating a repository"

	REPOSITORY_NAMESPACE=$1
	REPOSITORY_NAME=$2

	printf "Creating a repository: ${REPOSITORY_NAME}...\n\n"

	aws ecr describe-repositories --repository-names ${REPOSITORY_NAMESPACE}/${REPOSITORY_NAME} > /dev/null 2>&1
	if [ $? -eq 0 ]; then
		printf "${YELLOW}Repository already exists: ${REPOSITORY_NAMESPACE}/${REPOSITORY_NAME}${DEFAULT}\n\n"
		sleep 1
		return
	fi

	aws ecr create-repository --repository-name ${REPOSITORY_NAMESPACE}/${REPOSITORY_NAME} > /dev/null 2>&1

	printf "Repository created: ${REPOSITORY_NAMESPACE}/${REPOSITORY_NAME}\n\n"

	sleep 1
}
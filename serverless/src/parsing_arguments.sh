#!/bin/bash

parsing_arguments() {
	if [ $# -eq 1 ] && ([ $1 == '-h' ] || [ $1 == '--help' ]); then
		help
		exit 0
	fi

	if [ $# -eq 1 ] || [ $# -gt 2 ]; then
		help
		exit 1
	fi

	if [ $# -eq 2 ]; then
		if [ $1 == '-p' ] || [ $1 == '--profile' ]; then
			aws configure get aws_access_key_id --profile $2 &>/dev/null
			if [ $? -ne 0 ]; then
				printf "${RED}Error: Profile not found${DEFAULT}\n"
				printf "${RED}Run below command to check available profiles or create a new profile${DEFAULT}\n\n"
				printf "${YELLOW}$ aws configure list-profiles${DEFAULT}\n"
				exit 1
			fi
			AWS_PROFILE=$2
		else
			help
			exit 1
		fi
	fi
}
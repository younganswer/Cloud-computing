#!/bin/bash

parsing_arguments() {
	while [[ "$#" -gt 0 ]]; do
		case $1 in
			-h | --help)
				help
				exit 0
				;;
			-p | --profile)
				if [[ -n $2 && $2 != -* ]]; then
					aws configure get aws_access_key_id --profile $2 &>/dev/null
					if [ $? -ne 0 ]; then
						printf "${RED}Error: Profile not found${DEFAULT}\n"
						printf "Run below command to check available profiles or create a new profile\n\n"
						printf "${YELLOW}$ aws configure list-profiles${DEFAULT}\n"
						exit 1
					fi
					AWS_PROFILE=$2
					shift
				else
					printf "${RED}Error: Required argument is missing: $1${DEFAULT}\n\n"
					printf "Run below command to check available options\n\n"
					printf "${YELLOW}$ bash deploy.sh -h${DEFAULT}\n"
					exit 1
				fi
				;;
			*)
				printf "${RED}Error: Unknown parameter passed: $1${DEFAULT}\n\n"
				printf "Run below command to check available options\n\n"
				printf "${YELLOW}$ bash deploy.sh -h${DEFAULT}\n"
				exit 1
				;;
		esac
		shift
	done
}
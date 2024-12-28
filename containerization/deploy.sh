#!/bin/bash

PATH_DEPLOY="$(cd "$(dirname "$0")" && pwd -P)"

exec 2> /dev/null

source src/color.sh
source src/help.sh
source src/parsing_arguments.sh
source src/util.sh
source src/variable.sh
source src/deploy/create_bucket.sh
source src/deploy/create_repository.sh
source src/deploy/deploy_stack.sh
source src/deploy/push_image.sh
source src/deploy/upload.sh

parsing_arguments $@

clear

# Set AWS profile and region ----------------------------------------------------
	AWS_ACCOUNT_ID=$(aws sts get-caller-identity --profile ${AWS_PROFILE} --query "Account" --output text)
	AWS_REGION=$(aws configure get region --profile ${AWS_PROFILE})
# -------------------------------------------------------------------------------

# Build deployment --------------------------------------------------------------
	create_bucket "deployment-${AWS_ACCOUNT_ID}-${AWS_REGION}"
	upload "cloudformation" "deployment-${AWS_ACCOUNT_ID}-${AWS_REGION}"

	create_repository "coffee-supplier" "customer"
	push_image "coffee-supplier" "customer"

	create_repository "coffee-supplier" "employee"
	push_image "coffee-supplier" "employee"
# -------------------------------------------------------------------------------

deploy_stack "CoffeeSupplier" "deployment-${AWS_ACCOUNT_ID}-${AWS_REGION}"

clean

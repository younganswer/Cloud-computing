#!/bin/bash

PATH_DEPLOY="$(cd "$(dirname "$0")" && pwd -P)"

exec 2> /dev/null

source src/color.sh
source src/help.sh
source src/parsing_arguments.sh
source src/util.sh
source src/variable.sh
source src/deploy/build_static_website.sh
source src/deploy/create_bucket.sh
source src/deploy/deploy_stack.sh
source src/deploy/upload.sh

parsing_arguments $@

clear

AWS_ACCOUNT_ID=$(aws sts get-caller-identity --profile ${AWS_PROFILE} --query "Account" --output text)
AWS_REGION=$(aws configure get region --profile ${AWS_PROFILE})

create_bucket "deploy-${AWS_ACCOUNT_ID}-${AWS_REGION}"

upload "cloudformation" "deploy-${AWS_ACCOUNT_ID}-${AWS_REGION}"

upload "lambda" "deploy-${AWS_ACCOUNT_ID}-${AWS_REGION}"

deploy_stack "CoffeeSupplier" "deploy-${AWS_ACCOUNT_ID}-${AWS_REGION}"

build_static_website "static-website" "CoffeeSupplier"

clean

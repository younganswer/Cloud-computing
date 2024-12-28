#!/bin/bash

PATH_DESTROY="$(cd "$(dirname "$0")" && pwd -P)"

exec 2> /dev/null

source src/color.sh
source src/help.sh
source src/parsing_arguments.sh
source src/util.sh
source src/variable.sh
source src/destroy/delete_bucket.sh
source src/destroy/delete_stack.sh

parsing_arguments $@

clear

AWS_ACCOUNT_ID=$(aws sts get-caller-identity --query "Account" --output text)
AWS_REGION=$(aws configure get region)

delete_stack "CoffeeSupplier"

delete_bucket "deploy-${AWS_ACCOUNT_ID}-${AWS_REGION}"

clean

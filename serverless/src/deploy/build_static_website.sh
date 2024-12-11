#!/bin/bash

build_static_website() {
	print_title "Building a static website"

	FILE_PATH="${PATH_DEPLOY}"/deployment/$1
	STACK_NAME=$2

	build_config() {
		local FILE_PATH="${FILE_PATH}"/$1
		local API_GATEWAY_NAME=$2
		local API_GATEWAY_ID=$(aws apigatewayv2 get-apis --query "Items[?Name=='${API_GATEWAY_NAME}'].ApiId" --output text)
		local API_GATEWAY_URL="https://${API_GATEWAY_ID}.execute-api.${AWS_REGION}.amazonaws.com"

		printf "const config = {\n" > "${FILE_PATH}"/config.js
		printf "\tAPI_URL: '${API_GATEWAY_URL}',\n" >> "${FILE_PATH}"/config.js
		printf "};\n" >> "${FILE_PATH}"/config.js
	}

	build_config "customer" "CustomerAPIGateway"
	build_config "employee" "EmployeeAPIGateway"

	aws s3api head-bucket --bucket ${BUCKET_NAME} > /dev/null 2>&1
	if [ $? -ne 0 ]; then
		printf "${RED}Error: Bucket does not exist: ${BUCKET_NAME}${DEFAULT}\n\n"
		sleep 1
		return 1
	fi

	aws s3 cp "${FILE_PATH}" s3://static-website-${AWS_ACCOUNT_ID}-${AWS_REGION} --recursive
	
	printf "\n"

	sleep 1
}
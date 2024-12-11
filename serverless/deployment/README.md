# Deployment

This directory contains the deployments for the serverless application.

<br/>
<br/>

## Cloudformation

It deploys main stack using `/cloudformation/main.yaml` template.

Main stack creates nested stacks for the following resources:

-   Parameter stack
-   Mapping stack
-   VPC stack
-   Database stack
-   Lambda stack
-   S3 stack
-   API Gateway stack

You can check the deployments in [cloudformation](cloudformation) directory.

<br/>
<br/>

## Lambda functions

Customer lambda function and Employee lambda function are deployed by cloudformation stack.

You can check the deployments in [lambda](lambda) directory.

<br/>
<br/>

## Static website

Static website is deployed using S3 bucket.

You can check the deployments in [website](website) directory.

# Deployment

This directory contains the deployments for the containerized application.

<br/>
<br/>

## Cloudformation

It deploys main stack using `/cloudformation/main.yaml` template.

Main stack creates nested stacks for the following resources:

-   VPC stack
-   EC2 stack (Security Group)
-   RDS stack
-   ELB stack
-   ECS stack

You can check the deployments in [cloudformation](cloudformation) directory.

<br/>
<br/>

## Container

Container directory contains the deployments for the containerized application. Each subdirectory corresponds to a single microservice, and is responsible for generating the image that constitutes the respective container.

You can check the deployments in [container](container) directory.

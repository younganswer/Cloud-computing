# Containerization

This project demonstrates the deployment of a fully-managed microservice architecture using AWS ECS Fargate, leveraging containerization to achieve scalability, reliability, and cost efficiency. By utilizing the serverless Fargate model, eliminated the need to manage underlying EC2 instances, allowing seamless focus on application development. The architecture integrates with AWS services like Application Load Balancer for traffic distribution and CloudWatch for centralized monitoring and logging. Automated scaling through ECS Service Auto Scaling, ensuring optimal resource utilization under varying loads while maintaining high availability. This architecture streamlines operations and delivers a robust foundation for modern, cloud-native applications.

<br/>
<br/>

## Background

Due to the lack of IAM account creation permissions for the assigned IAM account, I was unable to use AWS CDK. Because AWS CDK Bootstrap requires IAM account creation permissions. Therefore, I write shell scripts manually.

<br/>
<br/>

## Supported Platforms

### AWS CLI version

```
$ aws --version
aws-cli/2.22.7 Python/3.12.6 Darwin/24.1.0 exe/x86_64
```

<br/>
<br/>

## Getting started

### Deployment

It deploys cloudformation stack using `/deployment/cloudformation/main.yaml` template.

Check the deployments in [deployment](deployment) directory.

<br/>
<br/>

## Running script

Script uses `AWS_PROFILE` environment variable to determine which AWS profile to use. If you want to use a different profile, you can set the `AWS_PROFILE` environment variable to the desired profile or use the `--profile` option.

### Deploy

```
$ bash deploy.sh --profile <profile>
```

### Destroy

```
$ bash destroy.sh --profile <profile>
```

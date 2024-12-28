# Serverless computing

Serverless computing is a cloud computing execution model where the cloud provider dynamically manages the allocation of machine resources. In this model, developers can focus on writing code without worrying about the underlying infrastructure. The term "serverless" does not mean that servers are no longer involved. Rather, it emphasizes that the operational aspects of server management are abstracted away from the developer.

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

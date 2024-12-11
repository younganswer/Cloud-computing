# Serverless computing

Serverless computing is a cloud computing execution model in which the cloud provider allocates machine resources on demand, taking care of the servers on behalf of their customers. Serverless computing does not eliminate servers, but instead seeks to emphasize the idea that computing resource considerations can be moved into the background during the development process.

<br/>
<br/>

# Background

Due to the lack of IAM account creation permissions for the assigned IAM account, I was unable to use AWS CDK. Because AWS CDK Bootstrap requires IAM account creation permissions. Therefore, I write shell scripts manually.

<br/>
<br/>

# Supported Platforms

## AWS CLI version

```
$ aws --version
aws-cli/2.22.7 Python/3.12.6 Darwin/24.1.0 exe/x86_64
```

<br/>
<br/>

# Getting started

## Deployment

It deploys cloudformation stack using `/deployment/cloudformation/main.yaml` template.

Check the deployments in [deployment](deployment) directory.

<br/>
<br/>

# Running script

Script uses `AWS_PROFILE` environment variable to determine which AWS profile to use. If you want to use a different profile, you can set the `AWS_PROFILE` environment variable to the desired profile or use the `--profile` option.

## Deploy

```
$ bash deploy.sh --profile <profile>
```

## Destroy

```
$ bash destroy.sh --profile <profile>
```

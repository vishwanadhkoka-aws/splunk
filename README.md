# suresh-test

## General

### Environments

- 

## Usage

### Sample usage

Usage example for deploying a compute related resource in prod environment:

```
cd src/compute
terraform workspace select prod
terraform apply -var-file=deployment/prod.tfvars -var 'aws_deployment_role=account-admin'
```

## Authors

- Simon Stamm <simon.stamm@tui.com>
- Sven Becker <sven.becker@tui.com>
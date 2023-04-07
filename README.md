# Playing with VPC Lattice

This repo is a part of the [blogpost]().

## Execution

```bash
aws cloudformation deploy --stack-name lattice-ec2 --template-file eu-central-1-ec2.yaml --region eu-central-1 --capabilities CAPABILITY_NAMED_IAM
aws cloudformation deploy --stack-name lattice-ecs --template-file eu-central-1-ecs.yaml --region eu-central-1 --capabilities CAPABILITY_NAMED_IAM
aws cloudformation deploy --stack-name lattice-itself --template-file eu-central-1-lattice.yaml --region eu-central-1 --capabilities CAPABILITY_NAMED_IAM
```

## Cleanup

```bash
aws cloudformation delete-stack --stack-name lattice-ec2 --region eu-central-1
aws cloudformation delete-stack --stack-name lattice-ecs --region eu-central-1
aws cloudformation delete-stack --stack-name lattice-itself --region eu-central-1
```

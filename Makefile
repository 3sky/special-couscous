default: validate

REGION := "us-east-1"

validate:
	@echo "Validating CloudFormation templates"
	cfn-lint ec2-formation.yaml
	cfn-lint ecs-formation.yaml
	

clean-ec2:
	aws cloudformation delete-stack --stack-name lattice-ec2 --region $(REGION)

clean-ecs:
	aws cloudformation delete-stack --stack-name lattice-ecs --region $(REGION)

clean-lattice:
	aws cloudformation delete-stack --stack-name lattice-itself --region $(REGION)

ec2: 
	cfn-lint ec2-formation.yaml
	aws cloudformation deploy --stack-name lattice-ec2 --template-file ec2-formation.yaml --region $(REGION) --capabilities CAPABILITY_NAMED_IAM

ecs:
	cfn-lint ecs-formation.yaml
	aws cloudformation deploy --stack-name lattice-ecs --template-file ecs-formation.yaml --region $(REGION) --capabilities CAPABILITY_NAMED_IAM

ecs-fastapi:
	cfn-lint ecs-formation.yaml 
	aws cloudformation deploy --stack-name lattice-ecs --template-file ecs-formation.yaml --region $(REGION) --capabilities CAPABILITY_NAMED_IAM --parameter-overrides ContainerImage=569999221.dkr.ecr.us-east-1.amazonaws.com/fastapi-repository:latest HCPath=/healtz

lattice: 
	aws cloudformation deploy --stack-name lattice-itself --template-file lattice-formation.yaml --region $(REGION) --capabilities CAPABILITY_NAMED_IAM

build: validate ec2 ecs lattice

clean: clean-ec2 clean-ecs clean-lattice
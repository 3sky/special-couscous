
default: validate

validate:
	@echo "Validating CloudFormation templates"
	cfn-lint eu-central-1-ec2.yaml
	cfn-lint eu-central-1-ecs.yaml
	cfn-lint eu-central-1-lattice.yaml
	

ec2: 
	cfn-lint eu-central-1-ec2.yaml
	aws cloudformation deploy --stack-name lattice-ec2 --template-file eu-central-1-ec2.yaml --region eu-central-1 --capabilities CAPABILITY_NAMED_IAM

clean-ec2:
	aws cloudformation delete-stack --stack-name lattice-ec2 --region eu-central-1

clean-ecs:
	aws cloudformation delete-stack --stack-name lattice-ecs --region eu-central-1

clean-lattice:
	aws cloudformation delete-stack --stack-name lattice-itself --region eu-central-1

ecs:
	cfn-lint eu-central-1-ecs.yaml
	aws cloudformation deploy --stack-name lattice-ecs --template-file eu-central-1-ecs.yaml --region eu-central-1 --capabilities CAPABILITY_NAMED_IAM

lattice: 
	cfn-lint ec-central-1-lattice.yaml
	aws cloudformation deploy --stack-name lattice-itself --template-file eu-central-1-lattice.yaml --region eu-central-1 --capabilities CAPABILITY_NAMED_IAM

build: validate ec2 ecs lattice

clean: clean-ec2 clean-ecs clean-lattice
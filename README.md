## Detailed summary of the solution of the assigned task 

## I have created a terraform module for creation of :
- S3 bucket for storing state file and terraform lock as well
- ECR Repo
- ECS cluster along with a capacity provider to which and ASG is attached
- ECS Task Defination
- ECS Service
- ASG
- Launch Template

## Steps related to terraform module

- Note : We have have provided the path to my aws credentials in the providers.tf file and defined the region as well

- Firstly we will create and S3 bucket with terraform lock along with an ECR repo in aws 
  - We will have to go /ecs-terraform/s3 and run [terraform init, terraform plan & terraform apply].
  - This creates an S3 bucket, a dynamo db table lock on bucket and an ecr repo as well as we have kept the ecr.tf file as well
  - Now we have an S3 bucket created with versioning and Encryption.

- Now we have an S3 bucket to store the remote state now we will create a terraform backend file inside [/ecs-terrform]
  - After creating a terraform backend file then we must in directory /ecs-terraform and execute [terraform init]
  - Once terraform init is initiated it will initialize the backend and the provider plugins

- Once the terraform is initialized in [/ecs-terraform] the we can perform [terraform plan , terraform apply ]
- After this is done all the resources will be created in the aws environment

## Details about the tf files in /ecs-terraform
 
 - [providers.tf] This file contains provider information as well the path to aws credentials
 - [backend.tf ] This contains the terraform backend information of S3 
 - [launchtemplate.tf] This file creates a launch template with values
    - AMI(ECS-optimized),Instance type(based on the task defination which we need to run) and other values
 - [asg.tf] This file creates an ASG with the entered values and uses a launch template that is created in another tf file.
 - [iamrole.tf] This file creates an ecsInstancerole with a policy AmazonEC2ContainerServiceforEC2Rol that will be added to instance that will be      launched by Launch template
 - [ecscluster.tf] This file creates a ecs cluster along with a capacity provider attached to it and capacity provider has an ASG attached as well.
 - [ecsservice.tf] This file creates services in the launched cluster in [ecscluster.tf] and uses the task defination defined in [taskdefination.tf]
 - [taskdefination.tf] This file creates a task defination i have mentioned the CPU & Memory can be changed as per requirement. 
     Note : ECR repo arn mentioned is my own ecr repo it can be changed as well
 -[ S3 folder] This folder contains tf files for s3 creation along with dynamodb lock and ecr repo creation tf file
 
  
## SQS MODULE

Question : There is SQS in which you push the message and then Node automatically spin up and
attach to ECS cluster.

Solution :

- We can create an SQS queue 
- We must have an Cloudwatch alarm configured on the SQS queue on metric_name = "ApproximateNumberOfMessagesVisible" and thresold set at >= 1
- We must have and ASG with a launch template 
- We must have Autocaling policy for created ASG associated with the SQS alarm.
- As soon as the a message is pushed to SQS queue the Alarm triggers the autoscaling policy which in turn spins up an instance
- ASG must be asociated with the Capacity provider of the Desired ECS cluster
- As soon as the instance is launched it will be attached to the acs cluster

I have created a terraform module for this solution as well.

Note : I have created a new ECS cluster in this module however we can use the above the created cluster as well.

## Use cases mentioned in the question are tested :
- Autoscaling policy working fine when changing the desired instance
- If instance type is chnaged in launched template it reflects in ASG 
- S3 storage of state file and versioning
- Terraform lock on state file tested as well.









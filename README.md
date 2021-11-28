# ci-cd-host-static-website

### Project Overview

Creating a Cloud Formation template to setup the infrastructure needed to deploy an highly available static web application and create the ci/cd pipeline for deploying the application. Finally access the application using public URL of the LoadBalancer.

### Architecture Diagram

The resources to be created are as follows:

* VPC to create a own private cloud that is isolated from other networks within the AWS cloud
* Internet Gateway and associate it to VPC inorder to provide access to outside network traffic
* Load Balancer to forward traffic, evenly across a group of servers, known as a Target Group. Here servers within autoscaling group are the target group.LB      Listerners that listens on a port and routes the traffic to the target group
* Public and Private Subnets to restrict direct access to resources within the VPC from outside network
* Route table that defines the set the routing rules for the the incoming and outgoing network traffic. Subnets are associated with the route table
* NAT Gateway placed in public subnet to access the application hosted on the server in private subnet
* Launch Configuration for the application servers in order to deploy four servers, two located in each of your private subnets. The launch configuration will be used by an auto-scaling group
* S3 bucket where the static index.html code is present
* IAM role that allows the instances to use the S3 Service
* Bastion server where Jenkins is installed and from this Jenkins server the ci/cd pipeline jobs are executed
* Security groups that is tied to the individual resources to control the access to them
    
#### Note

* Deploy servers with an SSH Key into Public subnets and open SSH port (port 22) while creating the script. This helps in troubeshooting issues later by logging into it
* Ensure Load balancer allows all public traffic (0.0.0.0/0) on port 80 inbound, which is the default HTTP port. Outbound on port 80 to reach the internal servers.
* Servers on which the application is running on a certain port should be open in the inbound security group rule attached to the server to access the application.
* User data script defining the required dependencies to be installed during the bootstraping of the servers. Datadog agents API key is stored in the AWS parameter store and would need to use the CLI in your userdata script to retrieve the value.

### This project conatins the following files and folders

* infra.yml: CloudFormation code using this YAML template for building the cloud infrastructure
* infra-Parameters.json: JSON file for increasing the generic nature of the YAML code. For example, the JSON file contains a "ParameterKey" as "EnvironmentName" and "ParameterValue" as "NameofProject".
* apache.yml: Ansible playbook for statring the httpd service on the target servers by copying the required index.html file to target path
* hosts.inv: Inventory consisting of the target servers ip address and user details
* Jenkinsfile: Contains the pipleline code for deploying the static application to taget servers whenever the new changes are made to the index.html file
* datadog-monitors: Consists of the terraform modules that defines the resources and use terraform apply command to deploy monitors in datadog

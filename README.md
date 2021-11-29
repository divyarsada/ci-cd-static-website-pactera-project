# ci-cd-host-static-website-pactra-project

### Project Overview

Creating a Cloud Formation template to setup the infrastructure needed to deploy an highly available static web application and create the ci/cd pipeline for deploying the application. Finally access the application using public URL of the LoadBalancer.

### Architecture Diagram Description

The resources to be created are as follows:

* VPC to create a own private cloud that is isolated from other networks within the AWS cloud
* Internet Gateway and associate it to VPC inorder to provide access to outside network traffic
* Load Balancer to forward traffic, evenly across a group of servers, known as a Target Group. Here servers within autoscaling group are the target group.LB Listerners that listens on a port and routes the traffic to the target group
* Public and Private Subnets to restrict direct access to resources within the VPC from outside network.
* Route table that defines the set the routing rules for the the incoming and outgoing network traffic. Subnets are associated with the route table. 
* NAT Gateway placed in public subnet to access the application hosted on the server in private subnet
* Launch Configuration for the application servers in order to deploy two servers, each located in  the private subnets. The launch configuration will be used by an auto-scaling group
* S3 bucket where the static index.html code is present, the path of the s3 bucket is specified in the user data field while defining the launch configuration 
* IAM role that allows the instances to use the S3 Service and access the SSM parameter store.
* Bastion server is present in the public subnet,on which Jenkins is installed. This Jenkins server is used for settin up the  pipeline jobs for ci/cd process.
* Security groups that is tied to the individual resources to control the access to them
    
#### Note

* Deploy servers with an SSH Key into Public subnets and open SSH port (port 22) while creating the script. This helps in troubeshooting issues later by logging into it
* Ensure Load balancer allows all public traffic (0.0.0.0/0) on port 80 inbound, which is the default HTTP port. Outbound on port 80 to reach the internal servers.
* Servers on which the application is running on a certain port should be open in the inbound security group rule attached to the server to access the application.
* User data script defining the required dependencies to be installed during the bootstraping of the servers. Datadog agents API key is stored in the AWS parameter store and would need to use the CLI in your userdata script to retrieve the value.

### This project conatins the following files and folders

* infra.yml: CloudFormation code using this YAML template for building the cloud infrastructure
* infra-Parameters.json: JSON file for increasing the generic nature of the YAML code. For example, the JSON file contains a "ParameterKey" as "EnvironmentName" and "ParameterValue" as "NameofProject".
* apache.yml: Ansible playbook for starting the httpd service on the target servers by copying the updated index.html file to target path on the target server
* hosts.inv: Inventory consisting of the target servers ip address and user details
* Jenkinsfile: Contains the pipleline code for deploying the static web application to target servers whenever the new changes are made to the index.html file and pushed to github
* datadog-monitors: Consists of the terraform modules that defines the datadog monitor resources and use terraform apply command to deploy monitors in datadog

### Steps to login and install jenkins on bastion server

##### Connect through SSH

* After creating the EC2 instance, copy the “IPv4 Public IP”.
* On Mac, using the terminal, using the username “ec2-user” and “.pem” key 
    ```
    ssh -i "<Keypair>" <username>@<ip-address>
    ```

##### Install Jenkins and create the pipeline job 

* Install Jenkins on Instance. For installation instructions refer link ![Jenkins setup](https://pkg.jenkins.io/redhat-stable/)
* After Jenkins is setup. Visit Jenkins on its default port, 8080, with your server IP address or domain name included like this: `http://your_server_ip_or_domain:8080`. Ensure the port 8080 traffic is allowed into the instance.
* Install required plugins(BlueOcean and pipeline-aws). BlueOcean helps in creating a pipeline by linking the github repo
* Jenkins is integrated with github repository by creating webhooks
* Jenkins fetches the changes on the ci-cd-static-website-pactra-project repository. 
* Ansible playbook is created, which copies the changed index.html file into the target server
* Set up GitHub with the project repository and add the Jenkinsfile.
* Set up AWS credentials in Jenkins
* Set up S3 Bucket and create a bucket policy to give required permissions to access the bucket.
* Create a stage in Jenkins file to upload the "index.html" file to s3 bucket using the region and credentials for AWS. For further info click ![withAWS](https://github.com/jenkinsci/pipeline-aws-plugin#withaws.),![s3upload](https://github.com/jenkinsci/pipeline-aws-plugin#s3upload)
* To prevent getting an invalid HTML, run a linter so that it fails the job if anything gets in that is invalid

    ```
    Install the tidy linter in the server
    sudo apt-get install -y tidy
    ```
    ```
    Add stage lint with the below command
    tidy -q -e *.html
    ```
* Create a stage in Jenkinsfile to execute the ansible playbook.


Save, commit, and push. Within minutes, a new run should appear


To verify, go to the URL: `http://mysta-WebAp-160XTP67TIB53-193931316.us-east-1.elb.amazonaws.com:80`

Steps to install Terraform and datadog-aws integration

* For terraform installation instructions refer link ![Terraform setup](https://phoenixnap.com/kb/how-to-install-terraform-centos-ubuntu#ftoc-heading-2)
* Integrate datadog with aws. Follow the steps ![AWS-Datadog integration](https://docs.datadoghq.com/integrations/amazon_web_services/?tab=roledelegation)
* Use init, plan, and apply to Finish the Configuration
* With everything set:
    ```
    Initialize the configuration file:
        terraform init
    
    Validate the configuration file:
        terraform validate
    
    Create the execution plan:
        terraform plan

    Apply the changes:
        terraform apply
    ```
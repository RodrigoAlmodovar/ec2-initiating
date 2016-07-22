# ec2-initialization

A simple exercise to explore how to start instances in AWS
How it works:

##User data
The autoscaling group's 'userdata' field must be filled with this text.
This will be the code that the machine will execute (as root) as soon as it comes to life. It will update&upgrade the machine and install everything needed for the awscli, after all, it will copy the initialization.sh file from s3 to its dependencies, change its permissions and execute it.

##Initialization.sh
Install nginx and modify the files and virtual host needed to configure a site with 40 html files.

##CreateBastion.sh
This is the bash script for launching a bastion instance. It will need later to be manually configured for regulate the access through itself:
	- It must be reachable by SSH from the admin IP and it must have access to the instance by SSH
	- The API instances must be reachable by HTTP from anywhere and just from the Bastion by SSH
(In a future I will update this file to having everything configured automatically instead of having to do it manually)

The rest of the files are for testing the different 

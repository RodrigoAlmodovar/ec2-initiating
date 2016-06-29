#!/bin/bash

IMAGENAME=BASTION
INSTANCEID=i-076d3582c7db06190
IMAGEDESCRIP="An AMI for $IMAGENAME"


function createImage {
	aws ec2 create-image --instance-id $INSTANCEID --name $IMAGENAME --description "$IMAGEDESCRIP"

}

# aws configure
createImage
# aws ec2 create-image --instance-id i-034a9a2d28543a0de --name "BASTION" --description "An AMI for BASTION"
# apt install ec2-api-tools
#launchImage
# aws ec2 run-instances --image-id ami-b911ded4 --count 1 --instance-type t2.micro --key-name BASTIONKEYPAIR --security-group-ids sg-a3eaadd8 --subnet-id subnet-013c3c77 --tags Key=Name,Value=BASTION


#Si se configura desde el plugin no es necesario hacer un set de las claves
IMAGEID=ami-49df1124
INSTANCETYPE=t2.micro
KEYNAME=BASTIONKEYPAIR
SECURITYGROUP=sg-a3eaadd8
SUBNETID=subnet-013c3c77
TAGNAME=BASTION2
TAGENVIRONMENT=TEST

INSTANCEID=$(aws ec2 run-instances --region us-east-1 --image-id $IMAGEID --count 1 --instance-type $INSTANCETYPE --key-name $KEYNAME --security-group-ids $SECURITYGROUP --subnet-id $SUBNETID | grep InstanceId | awk '{print $2}'| sed 's/"//g' | sed 's/,//')
aws ec2 create-tags --region us-east-1 --resources $INSTANCEID --tags Key=Name,Value=$TAGNAME Key=ENV,Value=$TAGENVIRONMENT
sleep 5
aws ec2 terminate-instances --region us-east-1 --instance-ids $INSTANCEID

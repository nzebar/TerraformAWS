# resource "aws_ami_launch_permission" "permissionAMI" {
#   image_id   = data_aws_ami.productionAMI.id
#   account_id = "062812664163"
# }

# resource "aws_ami" "productionAMI" {
#   name                = "productionAMI"
#   virtualization_type = "hvm"
#   root_device_name    = "/dev/xvda"

#   ebs_block_device {
#     device_name = "/dev/xvda"
#     snapshot_id = "snap-1356"
#     volume_size = 30
#   }
# }

//Used to get the ID of the most recent AMI on AWS Console
data "aws_ami" "getAMI" { 
  most_recent      = true
  owners           = ["062812664163"] //Owner of the AMI.
  
}

resource "aws_instance" "webserverPRODUCTION" {
#  ami           = data.aws_ami.getAMI.id
  ami           = data.aws_ami.getAMI.id
  instance_type = "t2.micro"
  key_name = "webserverkeyPRODUCTION"

  tags = {
    Name = "webserver"
    value = "production"
  }
}

resource "aws_eip" "pubIPwebserver" {
  vpc = true
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.webserverPRODUCTION.id
  allocation_id = aws_eip.pubIPwebserver.id
}
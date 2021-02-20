resource "aws_default_vpc_dhcp_options" "default_dhcp_options_VPC1" {
  tags = {
    Name = "Default DHCP Option Set"
  }
}

resource "aws_vpc_dhcp_options" "dns_resolver_settings" {
  domain_name          = "www.nutsandbolts-online.us.to"
  domain_name_servers = ["AmazonProvidedDns"]
}

resource "aws_vpc_dhcp_options_association" "dns_resolver_VPC1_association" {
  vpc_id          = aws_vpc.VPC1.id
  dhcp_options_id = aws_vpc_dhcp_options.dns_resolver_settings.id
}

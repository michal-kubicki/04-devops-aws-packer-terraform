# Packer Example - LAMP based on Ubuntu Server

**Ubuntu Version**: 18.04

This example shows how to build and configure an Ubuntu Server running Apache, MariaDB and PHP and generate an AMI. The AWS region is set to eu-west-2 (London).

## Usage

```bash
packer build lapm.json
```

If you want to look up the AMI in a Terraform configuration, use filter and the ID tag:

``` terraform
data "aws_ami" "LAMP" {
  most_recent = true
  owners = ["self"]
  filter {
    name = "tag:ID"
    values = ["eu-west-2-US18-04-LAMP"]
  }
}
```

There is a working example included in the `terraform` directory. If you build an AMI first, Terraform will look it up automatically.

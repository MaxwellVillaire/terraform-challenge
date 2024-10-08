module "main_vpc" {
    source = "github.com/Coalfire-CF/terraform-aws-vpc-nfw"
    cidr = "10.1.0.0/16"
    azs = [data.aws_availability_zones.available.names[0], data.aws_availability_zones.available.names[1]]
    flow_log_destination_type = "s3"
    cloudwatch_log_group_kms_key_id = module.cloudfront_kms_key.kms_key_id
}

module "cloudfront_kms_key" {
  source                    = "github.com/Coalfire-CF/ACE-AWS-KMS?ref=v1.0.0"
  resource_prefix = local.resource_prefix
  kms_key_resource_type = "cloudfront"
  key_policy = data.aws_iam_policy_document.cloudfront_kms_policy.json
}

module "ec2" {
    source = "github.com/Coalfire-CF/terraform-aws-ec2"
    name = local.instance_name
    ami = local.redhat_ami_id
    ec2_instance_type = "t2.micro"
    instance_count = 1
    vpc_id = module.main_vpc.vpc_id
    subnet_ids = module.main_vpc.public_subnets[1]
    root_volume_size = local.root_volume_size
    ebs_kms_key_arn = module.ebs_kms_key.kms_key_arn
    ec2_key_pair = local.ec2_key_pair_name
    global_tags = {
        "InstanceType": "Public"
    }
  # Security Group Rules
    ingress_rules = {
        # This is a public subnet and the instance purpose is not defined, so no restrictions on ingress or egress.
        "allow_all_ingress" = {
        ip_protocol = "-1"
        from_port   = "0"
        to_port     = "0"
        cidr_ipv4   = "0.0.0.0/0"
        description = "Allow all ingress"
        }
    }

    egress_rules = {
        "allow_all_egress" = {
        ip_protocol = "-1"
        from_port   = "0"
        to_port     = "0"
        cidr_ipv4   = "0.0.0.0/0"
        description = "Allow all egress"
        }
    }
}

module "ebs_kms_key" {
  source                    = "github.com/Coalfire-CF/ACE-AWS-KMS?ref=v1.0.0"
  resource_prefix = local.resource_prefix
  kms_key_resource_type = "ebs"
  key_policy = data.aws_iam_policy_document.ebs_kms_policy.json
}
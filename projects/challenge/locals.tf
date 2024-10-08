locals {
    # TODO subnet names are defined in the design document, but should consider choosing more descriptive names
    public_subnets = {
        "Sub1": "10.1.0.0/24",
        "Sub2": "10.2.0.0/24"
    }
    private_subnets = {
        "Sub3": "10.3.0.0/24",
        "Sub4": "10.4.0.0/24"
    }
    mgmt_account_id = "123456789000"    
    app_account_id = "987654321000"
    resource_prefix = "example"
    instance_name = "example_instance"
    redhat_ami_id = "1234"
    root_volume_size = "20gb"
    ec2_key_pair_name = "example-key-pair"
}
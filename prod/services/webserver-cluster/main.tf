provider "aws" {
    region = "us-east-2"
}

module "webserver-cluster" {
    source = "../../../modules/services/webserver-cluster"

    cluster_name = "webservers-prod"
    db_remote_state_bucket = "backon-learn-terraform-state"
    db_remote_state_key = "prod/data-stores/terraform.tfstate"

    instance_type = "t3.micro"
    min_size = 2
    max_size = 10
}

terraform {
    backend "s3" {
        bucket = "backon-learn-terraform-state"
        key = "prod/services/webserver-cluster/terraform.tfstate"
        region = "us-east-2"

        use_lockfile = true
        encrypt = true
    }
}
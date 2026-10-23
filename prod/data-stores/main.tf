provider "aws" {
    region = "us-east-2"
}

resource "aws_db_instance" "prod-db" {
    identifier_prefix = "terraform-up-and-running-prod"
    engine = "mysql"
    allocated_storage = 10
    instance_class = "db.t3.micro"
    skip_final_snapshot = true
    db_name = "stage_database"

    username = var.db_username
    password = var.db_password
}

terraform {
    backend "s3" {
        bucket = "backon-learn-terraform-state"
        key = "prod/data-stores/terraform.tfstate"
        region = "us-east-2"

        use_lockfile = true
        encrypt = true
    }
}
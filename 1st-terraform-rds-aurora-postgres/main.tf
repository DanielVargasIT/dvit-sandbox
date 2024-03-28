provider "aws" {
  region = "us-east-1"
}

data "aws_kms_key" "by_id" {
  key_id = "00000000-0000-0000-0000-000000000000" # type KMS here
}

resource "aws_security_group" "example" {
  name_prefix = "example-"
  ingress {
    from_port   = 0
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

 resource "aws_rds_cluster_instance" "example" {
    identifier             = var.db-inventory
    cluster_identifier     = aws_rds_cluster.example.cluster_identifier
    engine                 = "aurora-postgresql"
    engine_version         = "15.3"
    instance_class         = "db.t3.large"
}

resource "aws_rds_cluster" "example" {
  cluster_identifier      = "example-aurora-cluster"
  engine                  = "aurora-postgresql"
  engine_version          = "15.3"
  availability_zones      = ["us-east-1a", "us-east-1b"]
  database_name           = var.db-name
  master_username         = var.db-username
  master_password         = var.db-password
  db_subnet_group_name    = var.db-subnet-group
  skip_final_snapshot     = true
}
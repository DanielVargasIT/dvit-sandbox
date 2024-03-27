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

resource "aws_db_instance" "example" {
  engine                 = "postgres"
  engine_version         = "15.2"
  db_name                = "example"
  identifier             = "mydb"
  instance_class         = "db.t3.medium"
  allocated_storage      = 20
  publicly_accessible    = true
  username               = var.db-username
  password               = var.db-password
  vpc_security_group_ids = [aws_security_group.example.id]
  kms_key_id             = data.aws_kms_key.by_id.arn
  storage_encrypted      = true
}
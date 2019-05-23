provider "aws" {
  access_key = "AKIAINZJVYHB5BOT7IRQ"
  secret_key = "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"
  region     = "us-east-1"
}

resource "aws_security_group" "sg_littlehack" {
  name        = "sg_littlehack"
  description = "Allow inbound DNS requests"

  ingress {
    # TLS (change to whatever ports you need)
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    # TLS (change to whatever ports you need)
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    prefix_list_ids = ["pl-12c4e678"]
  }
}

resource "aws_instance" "pihole-east1" {
  ami               = "ami-2757f631"
  instance_type     = "t2.micro"
  key_name          = "littlehack"
  security_groups   = [
    "sg_littlehack"
  ]
}

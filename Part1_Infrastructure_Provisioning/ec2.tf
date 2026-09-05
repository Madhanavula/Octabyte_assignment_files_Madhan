resource "aws_instance" "app" {
  count = 2

  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name

  subnet_id = aws_subnet.public[count.index].id

  vpc_security_group_ids = [
    aws_security_group.app.id
  ]

  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash

              dnf update -y

              dnf install -y python3

              mkdir -p /opt/hello-app

              cat <<'PYTHON' > /opt/hello-app/app.py
              from flask import Flask

              app = Flask(__name__)

              @app.route("/")
              def hello():
                  return "Hello World from Terraform AWS!"

              if __name__ == "__main__":
                  app.run(host="0.0.0.0", port=5000)
              PYTHON

              pip3 install flask

              cd /opt/hello-app

              nohup python3 app.py > /var/log/hello-app.log 2>&1 &
              EOF

  tags = {
    Name = "${var.project_name}-app-${count.index + 1}"
  }
}

resource "terraform_data" "example1" {
  provisioner "local-exec" {
    command     = "open WFH, '>completed.txt' and print WFH scalar localtime"
    interpreter = ["perl", "-e"]
  }
}
resource "null_resource" "create_completed_file" {
  provisioner "local-exec" {
    command = "echo 'Terraform execution completed' > completed.txt"
  }
}


resource "terraform_data" "example1" {
  provisioner "local-exec" {
    command     = "open WFH, '>completed.txt' and print WFH scalar localtime"
    interpreter = ["perl", "-e"]
  }
}

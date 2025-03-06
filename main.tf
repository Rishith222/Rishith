provider "local" {}

resource "local_file" "example_directory" {
  filename = "${path.module}/my_folder/example.txt"
  content  = "This is an example file created by Terraform."
}

resource "null_resource" "create_folder" {
  provisioner "local-exec" {
    command = "mkdir -p ${path.module}/my_folder"
  }
}

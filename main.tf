resource "null_resource" "local_provisioner" {
  provisioner "local-exec" {
    command = "echo 'Provisioning complete!' > /tmp/provisioning.log"
  }
}

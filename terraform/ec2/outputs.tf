output "jenkins_public_ip" {
  value = aws_instance.jenkins.public_ip
}

output "jenkins_ssh_command" {
  value = "ssh -i ${var.jenkin_key_name}.pem ec2-user@${aws_instance.jenkins.public_ip}"
}

output "jenkins_initial_admin_password_hint" {
  value = "sudo cat /var/lib/jenkins/secrets/initialAdminPassword"
}

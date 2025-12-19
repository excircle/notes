# How to Generate A Hosts File From Terraform

The following one-liner shows how to generate `/etc/hosts` file material from an existing Terraform state

```bash
terraform show -json | jq -r '.values.root_module.child_modules[].resources[] | select(.type == "aws_instance") | "\(.values.public_ip) \(.index)"'
```
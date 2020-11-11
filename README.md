# ASG example

This example shows how to launch instances using Auto Scaling Groups.

This creates a security group, launch configuration, auto scaling group and attach them to an ELB.

The example uses a custom AMIs.

Make sure you change the list of availability zones that is applicable to your account and region.

To run, configure your AWS provider as described in https://www.terraform.io/docs/providers/aws/index.html

Running the example

For planning phase 

```
terraform plan -var="image_id={your_ami_id}" -var="key_name={your_key_name}"
```

For apply phase

```
terraform plan -var="image_id={your_ami_id}" -var="key_name={your_key_name}"
```

Alternatively to using `-var` with each command, the `terraform.template.tfvars` file can be copied to `terraform.tfvars` and updated.

Once the stack is created, wait for few minutes and test the stack by launching a browser with ELB url.

To remove the stack

```
 terraform destroy -var="image_id={your_ami_id}" -var="key_name={your_key_name}"
```

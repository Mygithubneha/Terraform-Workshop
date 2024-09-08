# 🌍 Managing Multiple Environments with Terraform

This guide will help you set up **multiple environments** like `dev`, `prod`, and `QA` using **Terraform**. We will use **Terraform Workspaces** and **Reusable Modules** to manage these environments efficiently.

---

## 🌟 Why Manage Multiple Environments?

Managing environments like `development`, `staging`, and `production` helps ensure that you don't mix up deployments and configurations. Each environment will have its own **state file** and separate infrastructure.

---

## 🛠 Technologies Used:
- **Terraform**: For provisioning infrastructure.
- **AWS**: As the cloud provider.
- **S3**: To store Terraform state files.

---

## 📋 Step-by-Step Guide

### 1. Set Up Workspaces with Terraform

Workspaces help us manage different **state files** for each environment without duplicating configuration files.

#### ⚙️ Commands to Manage Workspaces:

```bash
terraform workspace list        # Lists all workspaces
terraform workspace new dev     # Creates a new workspace (e.g., dev)
terraform workspace select dev  # Selects the dev workspace
terraform workspace delete dev  # Deletes the dev workspace
```

## 2. Configure Terraform Backend
You'll need an S3 bucket to store the state files. Make sure to configure the backend block in your main.tf to specify the S3 bucket and key:

```hcl
terraform {
  backend "s3" {
    bucket = "your-terraform-state-bucket"
    key    = "path/to/terraform.tfstate"
    region = "us-east-1"
  }
}
```

## 3. Deploying EC2 Instances in Different Workspaces 🚀
Deploy EC2 instances in different environments by switching between workspaces.

## EC2 Configuration:
In your Terraform configuration, use the following:

```hcl
resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  tags = {
    Name = "${terraform.workspace}-server"
  }
}
```

## 4. Variables Setup 📝
Define your variables in variables.tf and create .tfvars files for each environment (e.g., dev.tfvars, prod.tfvars):

```hcl
variable "instance_type" {
  default = "t2.micro"
}

variable "aws_region" {
  default = "us-east-1"
}
```

## 5. Reusable Modules for Multiple Environments 🔄
Another way to manage multiple environments is using Reusable Modules. Instead of duplicating configurations, store them in a single folder and reference them from each environment.

Example Module Block:

```hcl
module "ec2_module" {
  source = "../modules/ec2"
  instance_type = var.instance_type
  region = var.aws_region
}
```

Folder Structure:



![alt text](image-8.png)

Each environment (like dev and prod) will have its own folder with a module block that references the shared module configuration in /modules.

## 6. Deploying Resources
Switch to the workspace of your choice (e.g., dev):

```bash
terraform workspace select dev

terraform apply # or terraform plan
```
Run the following commands to see the plan and apply the changes:

```bash
terraform plan -var-file=dev.tfvars
terraform apply -var-file=dev.tfvars
```

## 7. Check the Output 📄

After applying the changes, check the output:

```bash
terraform output
``` 

You'll see the instance details, security group information, and tags for each environment.

## 🎉 Conclusion

You now have two powerful ways to manage multiple environments with Terraform:

1.Workspaces: Manage different state files from a single set of configuration files.

2.Reusable Modules: Separate environment-specific configurations in different folders.

















![alt text](image.png)
![alt text](image-1.png)
![alt text](image-2.png)
![alt text](image-3.png)
![alt text](image-4.png)
![alt text](image-5.png)
![alt text](image-6.png)
![alt text](image-7.png)

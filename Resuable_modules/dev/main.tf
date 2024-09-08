module "instance" {
    source = "../modules/EC2"
    instance_size = var.size
    env = var.env
    instance_name = var.instance_name
}

module "storage" {
  source = "../modules/S3"
  versioning = true
  bucket_name = var.bucket_name
  env = var.env
  
}
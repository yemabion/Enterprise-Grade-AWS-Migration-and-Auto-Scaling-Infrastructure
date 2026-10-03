variable "project_name" {
  description = "Project name"
  type        = string
  default     = "enterprise-wordpress-migration"
}

variable "vpc_id" {
  description = "Existing VPC ID"
  type        = string
  default     = "vpc-0ada34a1f52d3ced5"
}

variable "alb_subnets" {
  description = "Public subnets for the Application Load Balancer"
  type        = list(string)

  default = [
    "subnet-026ee2158be6707bd",
    "subnet-00b04dc219878c12d"
  ]
}

variable "private_subnets" {
  description = "Private subnets for WordPress Auto Scaling instances"
  type        = list(string)

  default = [
    "subnet-0b3ef0b3a7db46a6b",
    "subnet-001fe760101147f88"
  ]
}

variable "ami_id" {
  description = "Golden AMI containing the migrated WordPress application"
  type        = string
  default     = "ami-0eca44892f75af500"
}

variable "instance_type" {
  description = "EC2 instance type for WordPress"
  type        = string
  default     = "t3.micro"
}

variable "min_size" {
  description = "Minimum number of WordPress instances"
  type        = number
  default     = 1
}

variable "desired_capacity" {
  description = "Desired number of WordPress instances"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum number of WordPress instances"
  type        = number
  default     = 6
}
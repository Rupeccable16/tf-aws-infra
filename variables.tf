variable "vpc_cidr" {
  type        = string
  description = ""
}

variable "vpc_name" {
  type        = string
  description = ""
}

variable "public_route_table_name" {
  type        = string
  description = ""
}

variable "main_internet_gateway_name" {
  type        = string
  description = ""
}
variable "private_route_table_name" {
  type        = string
  description = ""
}
variable "region" {
  type        = string
  description = ""
}

variable "aws_availability_zones_availability" {
  type        = string
  description = ""
}

variable "public_subnet_1_cidr" {
  type        = string
  description = ""
}

variable "private_subnet_1_cidr" {
  type        = string
  description = ""
}

variable "public_subnet_2_cidr" {
  type        = string
  description = ""
}

variable "private_subnet_2_cidr" {
  type        = string
  description = ""
}

variable "public_subnet_3_cidr" {
  type        = string
  description = ""
}

variable "private_subnet_3_cidr" {
  type        = string
  description = ""
}


variable "availability_zone_1" {
  type        = string
  description = ""
}

variable "availability_zone_2" {
  type        = string
  description = ""
}

variable "availability_zone_3" {
  type        = string
  description = ""
}

variable "internet_cidr" {
  type        = string
  description = ""
}

variable "public_subnet_1_name" {
  type        = string
  description = ""
}

variable "private_subnet_1_name" {
  type        = string
  description = ""
}

variable "public_subnet_2_name" {
  type        = string
  description = ""
}

variable "private_subnet_2_name" {
  type        = string
  description = ""
}

variable "public_subnet_3_name" {
  type        = string
  description = ""
}

variable "private_subnet_3_name" {
  type        = string
  description = ""
}

variable "subnet_additional_bits" {
  type        = number
  description = ""
}

variable "data_ami_owner1" {
  type = string
  description = ""
}

variable "data_ami_owner2" {
  type = string
  description = ""
}

variable "data_ami_filter_parameter" {
  type = string
  description = ""  
}

variable "data_ami_filter_value" {
  type = string
  description = ""  
}

variable "aws_instance_type" {
  type = string
  description = ""  
}

variable "aws_instance_rootblock_volsize" {
  type = number
  description = ""  
}

variable "aws_instance_rootblock_voltype" {
  type = string
  description = ""  
}

variable "aws_instance_name" {
  type = string
  description = ""  
}

variable "aws_sg_name1" {
  type = string
  description = ""  
}

variable "aws_sg_description" {
  type = string
  description = ""  
}

variable "aws_sg_name2" {
  type = string
  description = ""  
}

variable "ip_protocol_1" {
  type = string
  description = ""
}

variable "ip_protocol_2" {
  type = string
  description = ""
}

variable "ssh_port" {
  type = string
  description = ""
}

variable "http_port" {
  type = string
  description = ""
}

variable "https_port" {
  type = string
  description = ""
}

variable "webapp_port" {
  type = string
  description = ""
}
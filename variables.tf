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

variable "internet_cidr_ipv6" {
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
  type        = string
  description = ""
}

variable "data_ami_owner2" {
  type        = string
  description = ""
}

variable "data_ami_filter_parameter" {
  type        = string
  description = ""
}

variable "data_ami_filter_value" {
  type        = string
  description = ""
}

variable "aws_instance_type" {
  type        = string
  description = ""
}

variable "aws_instance_rootblock_volsize" {
  type        = number
  description = ""
}

variable "aws_instance_rootblock_voltype" {
  type        = string
  description = ""
}

variable "aws_instance_name" {
  type        = string
  description = ""
}

variable "aws_sg_name1" {
  type        = string
  description = ""
}

variable "aws_sg_description" {
  type        = string
  description = ""
}

variable "aws_sg_name2" {
  type        = string
  description = ""
}

variable "ip_protocol_1" {
  type        = string
  description = ""
}

variable "ip_protocol_2" {
  type        = string
  description = ""
}

variable "ssh_port" {
  type        = string
  description = ""
}

variable "http_port" {
  type        = string
  description = ""
}

variable "https_port" {
  type        = string
  description = ""
}

variable "webapp_port" {
  type        = string
  description = ""
}

variable "aws_instance_key_name" {
  type        = string
  description = ""
}

variable "aws_sg_rds_name1" {
  type        = string
  description = ""
}

variable "aws_sg_rds_description" {
  type        = string
  description = ""
}

variable "aws_sg_rds_name2" {
  type        = string
  description = ""
}

variable "aws_rds_storage" {
  type        = number
  description = ""
}

variable "aws_rds_engine" {
  type        = string
  description = ""
}

variable "aws_rds_engine_version" {
  type        = string
  description = ""
}

variable "aws_rds_instance_class" {
  type        = string
  description = ""
}

variable "aws_rds_identifier" {
  type        = string
  description = ""
}

variable "aws_rds_username" {
  type        = string
  description = ""
}

variable "aws_rds_password" {
  type        = string
  description = ""
}

variable "aws_rds_db_name" {
  type        = string
  description = ""
}

variable "aws_rds_parameter_grp_name" {
  type        = string
  description = ""
}

variable "db_psql_port" {
  type        = string
  description = ""
}

variable "aws_db_subnet_grp_name" {
  type        = string
  description = ""
}

variable "aws_db_subnet_grp_nametag" {
  type        = string
  description = ""
}

variable "aws_ec2_role" {
  type        = string
  description = ""
}

variable "aws_s3_get_post_delete_list_policy_name" {
  type        = string
  description = ""
}

variable "aws_cloudWatchAgent_policy_arn" {
  type        = string
  description = ""
}

variable "aws_cloudWatchLogging_policy_arn" {
  type        = string
  description = ""
}

variable "aws_cloudWatchMetrics_policy_arn" {
  type        = string
  description = ""
}

variable "aws_iam_instance_profile_name" {
  type        = string
  description = ""
}

variable "aws_s3_bucket_tag_name" {
  type        = string
  description = ""
}

variable "aws_s3_bucket_tag_environment" {
  type        = string
  description = ""
}

variable "aws_s3_bucket_rule_id" {
  type        = string
  description = ""
}

variable "aws_s3_bucket_transition_days" {
  type        = number
  description = ""
}

variable "aws_s3_bucket_storage_class" {
  type        = string
  description = ""
}

variable "aws_route53_curr_acc_zone_id" {
  type        = string
  description = ""
}

variable "aws_route53_demo_acc_zone_id" {
  type        = string
  description = ""
}

variable "aws_route53_demo_subdomain_name" {
  type        = string
  description = ""
}

variable "aws_route53_demo_subdomain_record_type" {
  type        = string
  description = ""
}

variable "aws_route53_demo_subdomain_record_ttl" {
  type        = number
  description = ""
}

variable "aws_sg_loadbalancer_name1" {
  type        = string
  description = ""
}

variable "aws_sg_loadbalancer_description" {
  type        = string
  description = ""
}

variable "aws_sg_loadbalancer_name2" {
  type        = string
  description = ""
}

variable "aws_asg_name" {
  type        = string
  description = ""
}

variable "aws_asg_max_size" {
  type        = number
  description = ""
}

variable "aws_asg_min_size" {
  type        = number
  description = ""
}

variable "aws_asg_healthcheck_grace_period" {
  type        = number
  description = ""
}

variable "aws_asg_default_instance_warmup" {
  type        = number
  description = ""
}

variable "aws_asg_healthcheck_type" {
  type        = string
  description = ""
}

variable "aws_asg_desired_capacity" {
  type        = number
  description = ""
}

variable "aws_asg_tag_name" {
  type        = string
  description = ""
}

variable "aws_asg_tag_value" {
  type        = string
  description = ""
}

variable "aws_asg_scaleup_policy_name" {
  type        = string
  description = ""
}

variable "aws_asg_scaleup_policy_adjtype" {
  type        = string
  description = ""
}

variable "aws_asg_scaleup_policy_scaleadj" {
  type        = number
  description = ""
}

variable "aws_asg_scaleup_policy_cooldown" {
  type        = number
  description = ""
}

variable "aws_asg_scaledown_policy_name" {
  type        = string
  description = ""
}

variable "aws_asg_scaledown_policy_adjtype" {
  type        = string
  description = ""
}

variable "aws_asg_scaledown_policy_scaleadj" {
  type        = number
  description = ""
}

variable "aws_asg_scaledown_policy_cooldown" {
  type        = number
  description = ""
}

variable "aws_asg_cw_scaledown_alarm_description" {
  type        = string
  description = ""
}

variable "aws_asg_cw_scaledown_alarm_name" {
  type        = string
  description = ""
}

variable "aws_asg_cw_scaledown_alarm_comp_operator" {
  type        = string
  description = ""
}

variable "aws_asg_cw_scaledown_alarm_namespace" {
  type        = string
  description = ""
}

variable "aws_asg_cw_scaledown_alarm_metric_name" {
  type        = string
  description = ""
}

variable "aws_asg_cw_scaledown_alarm_metric_threshold" {
  type        = string
  description = ""
}

variable "aws_asg_cw_scaledown_alarm_metric_evalperiods" {
  type        = string
  description = ""
}

variable "aws_asg_cw_scaledown_alarm_metric_period" {
  type        = string
  description = ""
}

variable "aws_asg_cw_scaledown_alarm_metric_statistic" {
  type        = string
  description = ""
}

variable "aws_asg_cw_scaleup_alarm_description" {
  type        = string
  description = ""
}

variable "aws_asg_cw_scaleup_alarm_name" {
  type        = string
  description = ""
}

variable "aws_asg_cw_scaleup_alarm_comp_operator" {
  type        = string
  description = ""
}

variable "aws_asg_cw_scaleup_alarm_namespace" {
  type        = string
  description = ""
}

variable "aws_asg_cw_scaleup_alarm_metric_name" {
  type        = string
  description = ""
}

variable "aws_asg_cw_scaleup_alarm_metric_threshold" {
  type        = string
  description = ""
}

variable "aws_asg_cw_scaleup_alarm_metric_evalperiods" {
  type        = string
  description = ""
}

variable "aws_asg_cw_scaleup_alarm_metric_period" {
  type        = string
  description = ""
}

variable "aws_asg_cw_scaleup_alarm_metric_statistic" {
  type        = string
  description = ""
}

variable "aws_lb_name" {
  type        = string
  description = ""
}

variable "aws_lb_type" {
  type        = string
  description = ""
}

variable "aws_lb_tag_env" {
  type        = string
  description = ""
}

variable "aws_lb_listener_port" {
  type        = number
  description = ""
}

variable "aws_lb_listener_protocol" {
  type        = string
  description = ""
}

variable "aws_lb_listener_default_action_type" {
  type        = string
  description = ""
}

variable "aws_lb_targetgrp_name" {
  type        = string
  description = ""
}

variable "aws_lb_targetgrp_port" {
  type        = number
  description = ""
}

variable "aws_lb_targetgrp_protocol" {
  type        = string
  description = ""
}

variable "aws_lb_targetgrp_slowstart" {
  type        = number
  description = ""
}

variable "aws_lb_targetgrp_health_path" {
  type        = string
  description = ""
}

variable "aws_lb_targetgrp_health_matcher" {
  type        = string
  description = ""
}

variable "aws_lb_targetgrp_health_interval" {
  type        = number
  description = ""
}

variable "aws_lb_targetgrp_health_timeout" {
  type        = number
  description = ""
}

variable "aws_lb_targetgrp_health_healthy_threshold" {
  type        = number
  description = ""
}

variable "aws_lb_targetgrp_health_unhealthy_threshold" {
  type        = number
  description = ""
}

variable "aws_lb_targetgrp_tag_name" {
  type        = string
  description = ""
}

variable "aws_lb_sg_ingress_port1" {
  type        = number
  description = ""
}

variable "aws_lb_sg_ingress_port2" {
  type        = number
  description = ""
}

variable "aws_launch_template_name" {
  type        = string
  description = ""
}

variable "aws_launch_template_block_device_name" {
  type        = string
  description = ""
}

variable "aws_launch_template_ebs_vol_size" {
  type        = string
  description = ""
}

variable "aws_launch_template_ebs_vol_type" {
  type        = string
  description = ""
}

variable "aws_launch_template_shutdown_behavior" {
  type        = string
  description = ""
}

variable "aws_launch_template_tag_resource_type" {
  type        = string
  description = ""
}

variable "send_grip_api_key" {
  type        = string
  description = ""
}
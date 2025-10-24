variable "vpc_cidr_block" {
  type        = string
  default     = "10.0.0.0/16"
  description = "VPCに割り当てるCIDRブロックの記述"
}

variable "vpc_name" {
  type        = string
  description = "VPCの名前を指定する"
}

variable "vpc_env" {
  type        = string
  description = "ENVを指定する"
}
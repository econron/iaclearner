variable "vpc_cidr_block" {
  type        = string
  default     = "10.0.0.0/16"
  description = "VPCに割り当てるCIDRブロックの記述"
}

variable "service_name" {
  type        = string
  description = "VPCを利用するサービス名"
}

variable "env" {
  type        = string
  description = "ENVを指定する"
}

variable "vpc_tags" {
  type        = map(string)
  default     = {}
  description = "VPCリソースに付与したいタグ"
}

variable "vpc_additional_tags" {
  type        = map(string)
  default     = {}
  description = "VPCに付与したい追加タグ"

  validation {
    // 必須タグと重複するものがあればバリデーションエラーにする
    condition     = length(setintersection(keys(var.vpc_additional_tags), ["Name", "Env"])) == 0
    error_message = "Key names, Name and Env is reserved. Not allowed to use them."
  }
}

variable "subnet_cidrs" {
  description = "サブネットごとのCIDR指定"
  type = object({
    public = list(string)
    private = list(string)
  })

  validation {
    condition = (length(setintersection([
      for cidr in var.subnet_cidrs.public : (can(
        regex("^\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}/\\d{1,2}$", cidr)
      ) ? cidr : null)
    ], var.subnet_cidrs.public)) == length(var.subnet_cidrs.public))
    error_message = "Specify VPC Public Subnet CIDR block with the CIDR format"
  }

  validation {
    condition = (
      length([
        for cidr in var.subnet_cidrs.private : cidr
        if can(regex("^\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}/\\d{1,2}$", cidr))
      ]) == length(var.subnet_cidrs.private)
    )
    error_message = "Specify VPC Private Subnet CIDR block with the CIDR format."
  }

  # 可用性のためのバリデーション
  validation {
    condition = length(var.subnet_cidrs.public) >= 2
    error_message = "For availability, set more than or equal to public subnet cidrs."
  }
  validation {
    condition = length(var.subnet_cidrs.private) >= 2
    error_message = "For availability, set more than or equal to private subnet cidrs."
  }
  validation {
    condition = length(var.subnet_cidrs.public) == length(var.subnet_cidrs.private)
    error_message = "Redundancy of public subnet and private subnet must be same."
  }
}

variable "igw_additional_tags" {
  description = "igwに付与したいタグ"
  type = map(string)
  default = {}
  validation {
    condition = length(setintersection(keys(var.igw_additional_tags), ["Name", "Env", "VpcId"])) == 0
    error_message = "Key names, Name and Evn, VpcId are reserved. Not allowed to use them."
  }
}
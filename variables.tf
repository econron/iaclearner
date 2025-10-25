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
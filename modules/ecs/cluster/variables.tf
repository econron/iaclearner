variable "service_name" {
  default = "VPCを利用するサービス名"
  type = string
}

variable "env" {
  description = "環境識別子"
  type = string
}

variable "cluster_addtional_tags" {
  description = "ECSクラスターに付与したい追加タグ"
  type        = map(string)
  default     = {}

  validation {
    condition     = length(setintersection(
      toset(keys(var.cluster_addtional_tags)),
      toset(["ServiceName", "Env"])
    )) == 0
    error_message = "Key names, ServiceName and Env are reserved. Not allowed to use them."
  }
}
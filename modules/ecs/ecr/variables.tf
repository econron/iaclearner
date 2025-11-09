variable "service_name" {
  type = string
  description = "サービス名"
}

variable "env" {
  type = string
  description = "環境"
}

variable "ecr_additional_tags" {
  type = map(string)
  description = "ECRに付与したいタグ"
  default = {}
}

variable "role" {
    description = "リポジトリに格納するイメージのサービス内でのロール"
    type = string
}

variable "image_tag_mutability" {
  description = "イメージタグの変更を許可するかどうか"
  type = string
  default = "MUTABLE"
  validation {
    condition = contains(["IMMUTABLE", "MUTABLE"], var.image_tag_mutability)
    error_message = "image_tag_mutability must be one of IMMUTABLE or MUTABLE."
  }
}

variable "repository_lifecycle_policy" {
  description = "リポジトリのライフサイクルポリシー"
  type = string
  default =  <<DEFAULT
  {
    "rules": [
      {
        "rulePriority": 1,
        "description": "Keep last 100 images",
        "selection": {
          "tagStatus": "untagged",
          "countType": "sinceImagePushed",
          "countNumber": 30,
          "countUnit": "days"
        },
        "action": {
          "type": "expire"
        }
      }
    ]
  }
  DEFAULT
}
vpc_cidr_block="10.0.0.0/16"
service_name="sample"
env = "dev"
dynamodb_table="terraform_block"
vpc_additional_tags={
  Usage = "sample web server"
}
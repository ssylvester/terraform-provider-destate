variable "spacename" {
    description = "the workspace to derive state variables from"
    type = string
}

locals {
    # breakdown the workspace to figure out what we need to reference
    breakdown = regexall("(([a-z]+)-)?([a-z]+)-([a-z]+)", var.spacename)

    # grab the relevant information from the breakdown
    env = local.breakdown[0][2]
    location = local.breakdown[0][3]
    installation_name = "${local.breakdown[0][0] != null ? local.breakdown[0][0] : ""}${local.location}"

    alb_region_account_ids = {
     "us-east-1" = "127311923021"
      "us-east-2" = "033677994240"
      "us-west-1" = "27434742980"
      "us-west-2" = "797873946194"
      "ca-central-1" = "985666609251"
      "eu-central-1" = "54676820928"
      "eu-west-1" = "156460612806"
      "eu-west-2" = "652711504416"
      "eu-west-3" = "9996457667"
      "eu-north-1" = "897822967062"
      "ap-east-1" = "754344448648"
      "ap-northeast-1" = "582318560864"
      "ap-northeast-2" = "600734575887"
      "ap-northeast-3" = "383597477331"
      "ap-southeast-1" = "114774131450"
      "ap-southeast-2" = "783225319266"
      "ap-south-1" = "718504428378"
      "me-south-1" = "76674570225"
      "sa-east-1" = "507241528517"
    }

    # name for all relevant resources
    resource_name = "studio-${local.installation_name}-${local.env}"

    regions = {
      "dev-us"  = "us-east-2"
      "dev-ca"  = "us-east-2"
      "dev-uk"  = "us-east-2"
      "prod-ca" = "ca-central-1"
      "prod-uk" = "eu-west-2"
    }

    # region
    region = "${lookup(local.regions, "${local.env}-${local.location}")}"

    # alb account id
    alb_account_id = "${lookup(local.alb_region_account_ids, local.region)}"
}

output "env" {
    value = local.env
}

output "location" {
    value = local.location
}

output "installation_name" {
    value = local.installation_name
}

output "resource_name" {
    value = local.resource_name
}

output "region" {
    value = local.region
}

output "alb_account_id" {
    value = local.alb_account_id
}


module "context" {
  source = "../../"

  context_values = {
    org       = "A3Linux"
    dept      = "oneman"
    team      = "om"
    app       = "test"
    service   = "srv1"
    component = "com1"
    env       = "dev"
    alt_env   = "D"
    region    = "us-west-2"
    alt_region = "uw2"
  }

  label_attributes = ["service", "alt_env", "alt_region"]

  additional_tags = {
    "srv:id"    = "CONTEXT:id"
    "srv:label" = "CONTEXT:label"
    "srv:level" = "LVL-1"
  }
}

output "context" {
  value = module.context
}

locals {

  valid_attributes    = ["org", "dept", "team", "app", "service", "component", "env", "stage", "alt_env", "region", "alt_region"]

  placeholder_tag_values = [ "CONTEXT:label", "CONTEXT:id" ]

  available_attributes = [ for k in local.valid_attributes : k if contains(keys(var.context_values), k) ]
  input = { for a in local.available_attributes : a => var.context_values[a] == null ? "" : var.context_values[a] }

  normalized_label_list = [ for k in var.label_attributes : local.input[k] if local.input[k] != "" ]
  attributes_to_tags = [ for k in var.tag_attributes : k if local.input[k] != "" ]
  id_suffix = upper(substr(md5(uuid()), 0, 8))

  label = length(local.normalized_label_list) > 0 ? join(var.label_delimiter, local.normalized_label_list) : ""

  id = length(local.label) > 0 ? join(var.label_delimiter, [local.label, local.id_suffix]) : local.id_suffix

  auto_tags = { for k in local.attributes_to_tags : join("", [var.tag_prefix, upper(k)]) => lower(local.input[k]) }

  placeholder_keys = [ for k in keys(var.additional_tags) : k if contains(local.placeholder_tag_values, var.additional_tags[k]) ]
  additional_tags = { for k in keys(var.additional_tags) : k => var.additional_tags[k] if contains(local.placeholder_tag_values, var.additional_tags[k]) == false }
  placeholder_tags = { for k in local.placeholder_keys : k => var.additional_tags[k] == "CONTEXT:label" ? local.label : local.id }

  tags = merge(local.auto_tags, local.additional_tags, local.placeholder_tags)

  env = contains(keys(var.context_values), "env") ? var.context_values["env"] : "dev"

  region = contains(keys(var.context_values), "region") ? var.context_values["region"] : "us-west-2"
}

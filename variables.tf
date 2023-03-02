variable "context_values" {
  type          = map(any)
  default       = {}
  description   = "Input Context, valid keys[org, dept, team, app, service, component, env, stage, region]"
}

variable "label_attributes" {
  type          = list(string)
  default       = ["team", "service", "component", "env", "region"]
  description   = "The attributes and order to generate the tags and context.id"
}

variable "label_delimiter" {
  type          = string
  default       = "-"
  description   = "Delimiter for label and id"
}

variable "tag_attributes" {
  type          = list(string)
  default       = ["team",  "service",  "component", "env"]
  description   = "Attributes for tags"
}

variable "tag_prefix" {
  type          = string
  default       = "con:"
  description   = "Prefix string for each tag Name"
}

variable "additional_tags" {
  type          = map(any)
  default       = {}
  description   = "Additional Tag e.g. { Name = 'SampleName' }"
}

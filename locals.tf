locals {
  env    = (lower(terraform.workspace))
  region = (lookup(var.region, lower(var.location), "error"))
}

variable "app" {
  default = "net"
}

variable "location" {
  description = "Default Azure region"
  default     = "west europe"
}

variable "region" {
  default = {
    "north europe" = "neu"
    "west europe"  = "weu"
    "east us"      = "eus"
    "west us"      = "wus"
  }
}

#######################################

variable "vnet_address_space" {
  default = ["10.10.0.0/16"]
}

variable "subnet1_name" {
  default = "Frontend"
}

variable "subnet1_address_space" {
  default = "10.10.2.0/24"
}

variable "subnet2_name" {
  default = "Backend"
}

variable "subnet2_address_space" {
  default = "10.10.4.0/24"
}

variable "inbound_whitelist" {
  default = ["0.0.0.0/0"]
}

##############################

variable "vm_size" {
  default = "Standard_DS1_v2"
}
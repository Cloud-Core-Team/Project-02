variable "RSG_Name" {
  type    = string
  default = "EUS2-AVD-Development"
}

variable "location" {
    type = string
    default = "EastUS2"
}

variable "VNETName" {
    type = string
    default = "Network-AVD"
}

variable "Subnet" {
    type = map
    default = {
      "sub1" = "Machines"
      "sub2" = "AzureBastionSubnet"
    }
}
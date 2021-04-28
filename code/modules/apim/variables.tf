
#
variable "location" {
  type = string
}

#
variable "resource_name" {
  type = string
}

#
variable "resource_group_name" {
  type = string
}

#
variable "publisher_name" {
  type = string
}

#
variable "publisher_email" {
  type = string
}

#
variable "notification_sender_email" {
  type = string
}

#
variable "sku_name" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "tags" {
  type = map(any)
}

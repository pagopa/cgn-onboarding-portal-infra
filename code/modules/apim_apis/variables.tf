variable "project" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "api_management_name" {
  type = string
}

variable "backend_api_service_url" {
  type = string
}

variable "content_format" {
  type        = string
  description = "The format of the content from which the API Definition should be imported."
  default     = "swagger-json"
}

variable "content_value" {
  type        = string
  description = "The Content from which the API Definition should be imported."
}

variable "xml_content" {
  type        = string
  description = "The XML Content for this Policy as a string"
  default     = null
}

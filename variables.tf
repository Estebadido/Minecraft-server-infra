variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
  
}
variable "project" {
  description = "The project name for tagging resources"
  type        = string
  default     = "Minecraft-server"
  
}
variable "region" { 
    description = "Region de AWS"
    type        = string
}
variable "tags" {
    description = "Tags para los recursos"
    type        = map(string)
  
}
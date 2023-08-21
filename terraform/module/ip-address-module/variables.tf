variable "ip" {
    type = object({
        name            = string
        project_id      = string
        address_type    = string
        description     = optional(string)
    })  
}
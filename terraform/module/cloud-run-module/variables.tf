variable "cloud_run" {
    type = object({
        cloud_run_name             = string     
        project                    = string     
        region                     = string     
        location                   = string       
        service_account_name       = string   
        cloud_run_role             = optional(string)
        members                    = optional(list(string))
        min_instances              = optional(string)                   
        max_instances              = optional(string)
        cpu_limit                  = optional(string, "1000m")  
        memory_limit               = optional(string, "512Mi")                 
        container_image            = optional(string)   
        container_port             = optional(number, 80) 
        internal_or_external       = optional(string, "internal-and-cloud-load-balancing")    
        environment_variables      = optional(list(object({name=string, value=any})), [])                    
    })
}
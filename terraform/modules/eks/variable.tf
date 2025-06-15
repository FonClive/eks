variable "vpc_parameters" {
    description = "cluster parameters"
    type = map(object({
        cidr_block = string 
        enable_dns_support = optional(bool, true)
        enable_dns_hostnames = optional(bool, true)
        tags = optional(map(string), {})
    }))
    default = {}
}

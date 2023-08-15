variable "cidr_block" {
    description = "cider_block"
     default = ["192.168.0.16/28", "192.168.0.32/28"]
     type = list(string)
}
variable "availability_zone" {
    description = "availability zones"
    default = ["eu-west-1a", "eu-west-1b"]
    type = list(string)
}
variable "subnet_names" {
    description = "subnets"
    default = ["public_subnet_0", "public_subnet_1"]
    type = list(string)
  
}

variable "server_name" {
    description = "web server name"
    default = ["webserver_1", "webserver_2"]
    type = list(string)
}

variable "route_table_names" {
    description = "route table name"
    default = ["public_route_0", "public_route_1"]
    type = list(string)

}
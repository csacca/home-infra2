variable "cluster_name" {
  type        = string
  description = "Unique cluster name"
}

variable "matchbox_http_endpoint" {
  type        = string
  description = "Matchbox HTTP read-only endpoint (e.g. http://matchbox.example.com:8080)"
}

variable "matchbox_rpc_endpoint" {
  type        = string
  description = "Matchbox gRPC API endpoint, without the protocol (e.g. matchbox.example.com:8081)"
}

variable "os_stream" {
  type        = string
  description = "Fedora CoreOS release stream (e.g. stable, testing, next)"
  default     = "stable"

  validation {
    condition     = contains(["stable", "testing", "next"], var.os_stream)
    error_message = "The os_stream must be stable, testing, or next."
  }
}

variable "os_version" {
  type        = string
  description = "Fedora CoreOS version to PXE and install (e.g. 31.20200310.3.0)"
}

# machines

variable "nodes" {
  type = list(object({
    name        = string
    mac         = string
    domain      = string
    install_dev = string
  }))
}

# configuration

variable "ssh_authorized_key" {
  type        = string
  description = "SSH public key for user 'core'"
}

variable "snippets" {
  type        = map(list(string))
  description = "Map from machine names to lists of Butane snippets"
  default     = {}
}

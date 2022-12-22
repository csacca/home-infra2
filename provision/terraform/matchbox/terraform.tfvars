matchbox_http_endpoint = "http://matchbox.example.com:8080"
matchbox_rpc_endpoint  = "matchbox.example.com:8081"
talos_version          = "v1.3.0"

cluster_name = "home-ops"

nodes = [
  {
    name         = "polaris",
    mac          = "ac:1f:6b:1a:0b:ce",
    domain       = "polaris.mgmt.local",
    talos_config = "../../talos/clusterconfig/home-ops-polaris.mgmt.local.yaml"
  },
  {
    name         = "vega",
    mac          = "14:b3:1f:24:14:2d",
    domain       = "vega.mgmt.local",
    talos_config = "../../talos/clusterconfig/home-ops-vega.mgmt.local.yaml"
  },
  {
    name         = "capella",
    mac          = "6c:2b:59:d9:7f:22",
    domain       = "capella.mgmt.local",
    talos_config = "../../talos/clusterconfig/home-ops-capella.mgmt.local.yaml"
  }
]

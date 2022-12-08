matchbox_http_endpoint = "http://matchbox.example.com:8080"
matchbox_rpc_endpoint  = "matchbox.example.com:8081"
os_version             = "37.20221106.3.0"
ssh_authorized_key     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB9l8cv+eDVeYsuERyNX+kM93ajTuRNxJnpdKWAmkqoe"

cluster_name = "galaxy"

nodes = [
  {
    name        = "polaris",
    mac         = "ac:1f:6b:1a:0b:ce",
    domain      = "polaris.mgmt.local",
    install_dev = "/dev/nvme0n1"
  },
  {
    name        = "vega",
    mac         = "14:b3:1f:24:14:2d",
    domain      = "vega.mgmt.local",
    install_dev = "/dev/sda"
  },
  {
    name        = "capella",
    mac         = "6c:2b:59:d9:7f:22",
    domain      = "capella.mgmt.local",
    install_dev = "/dev/nvme0n1"
  }
]

snippets = {
  "polaris" = [
    "./snippets/common/mitigations.yaml",
    "./snippets/common/autologin.yaml",
    "./snippets/common/packages.yaml",
    "./snippets/common/console-font.yaml",
    "./snippets/polaris/networking.yaml"
  ],
  "vega" = [
    "./snippets/common/mitigations.yaml",
    "./snippets/common/autologin.yaml",
    "./snippets/common/packages.yaml",
    "./snippets/common/console-font.yaml",
    "./snippets/vega/networking.yaml"
  ],
  "capella" = [
    "./snippets/common/mitigations.yaml",
    "./snippets/common/autologin.yaml",
    "./snippets/common/packages.yaml",
    "./snippets/common/console-font.yaml",
    "./snippets/capella/networking.yaml"
  ]

}

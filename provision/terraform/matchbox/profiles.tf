locals {
  kernel = "/assets/fedora-coreos/fedora-coreos-${var.os_version}-live-kernel-x86_64"
  initrd = [
  "--name main /assets/fedora-coreos/fedora-coreos-${var.os_version}-live-initramfs.x86_64.img"]
}

// Fedora CoreOS node profile
resource "matchbox_profile" "nodes" {
  count = length(var.nodes)
  # tflint-ignore: terraform_deprecated_index
  name = format("%s-%s", var.cluster_name, var.nodes.*.name[count.index])

  kernel = local.kernel
  initrd = local.initrd

  args = [
    "initrd=main",
    "coreos.live.rootfs_url=${var.matchbox_http_endpoint}/assets/fedora-coreos/fedora-coreos-${var.os_version}-live-rootfs.x86_64.img",
    # tflint-ignore: terraform_deprecated_index
    "coreos.inst.install_dev=${var.nodes.*.install_dev[count.index]}",
    "coreos.inst.ignition_url=${var.matchbox_http_endpoint}/ignition?uuid=$${uuid}&mac=$${mac:hexhyp}",
  ]

  # tflint-ignore: terraform_deprecated_index
  raw_ignition = data.ct_config.nodes.*.rendered[count.index]
}

data "ct_config" "nodes" {
  count = length(var.nodes)
  content = templatefile("fcos/node.yaml", {
    ssh_authorized_key = var.ssh_authorized_key
  })
  strict = true
  # tflint-ignore: terraform_deprecated_index
  snippets = [for f in lookup(var.snippets, var.nodes.*.name[count.index], []) : file(f)]
}

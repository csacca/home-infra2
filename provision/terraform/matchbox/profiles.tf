locals {
  # tflint-ignore: terraform_unused_declarations
  cached_kernel = "/assets/fedora-coreos/fedora-coreos-${var.os_version}-live-kernel-x86_64"
  # tflint-ignore: terraform_unused_declarations
  cached_initrd = [
  "--name main /assets/fedora-coreos/fedora-coreos-${var.os_version}-live-initramfs.x86_64.img"]

  # tflint-ignore: terraform_unused_declarations
  cached_args = [
    "initrd=main",
    "coreos.live.rootfs_url=${var.matchbox_http_endpoint}/assets/fedora-coreos/fedora-coreos-${var.os_version}-live-rootfs.x86_64.img",
    "coreos.inst.ignition_url=${var.matchbox_http_endpoint}/ignition?uuid=$${uuid}&mac=$${mac:hexhyp}",
  ]

  remote_kernel = "https://builds.coreos.fedoraproject.org/prod/streams/${var.os_stream}/builds/${var.os_version}/x86_64/fedora-coreos-${var.os_version}-live-kernel-x86_64"
  remote_initrd = [
    "--name main https://builds.coreos.fedoraproject.org/prod/streams/${var.os_stream}/builds/${var.os_version}/x86_64/fedora-coreos-${var.os_version}-live-initramfs.x86_64.img",
  ]
  remote_args = [
    "initrd=main",
    "coreos.live.rootfs_url=https://builds.coreos.fedoraproject.org/prod/streams/${var.os_stream}/builds/${var.os_version}/x86_64/fedora-coreos-${var.os_version}-live-rootfs.x86_64.img",
    "coreos.inst.ignition_url=${var.matchbox_http_endpoint}/ignition?uuid=$${uuid}&mac=$${mac:hexhyp}",
  ]
}

// Fedora CoreOS node profile
resource "matchbox_profile" "nodes" {
  count = length(var.nodes)
  # tflint-ignore: terraform_deprecated_index
  name = format("%s-%s", var.cluster_name, var.nodes.*.name[count.index])

  kernel = local.remote_kernel
  initrd = local.remote_initrd

  # tflint-ignore: terraform_deprecated_index
  args = concat(local.remote_args, ["coreos.inst.install_dev=${var.nodes.*.install_dev[count.index]}"])

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

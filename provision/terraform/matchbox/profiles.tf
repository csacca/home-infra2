locals {

  remote_kernel = "https://github.com/siderolabs/talos/releases/download/${var.talos_version}/vmlinuz-amd64"
  remote_initrd = [
    "--name initramfs.xz https://github.com/siderolabs/talos/releases/download/${var.talos_version}/initramfs-amd64.xz"
  ]

  remote_args = [
    "initrd=initramfs.xz",
    "init_on_alloc=1",
    "slab_nomerge",
    "pti=on",
    "console=tty0",
    "console=ttyS0",
    "printk.devkmsg=on",
    "talos.platform=metal",
    "talos.config=${var.matchbox_http_endpoint}/generic?uuid=$${uuid}&mac=$${mac:hexhyp}",
    "talos.experimental.wipe=system"
  ]
}

// Fedora CoreOS node profile
resource "matchbox_profile" "nodes" {
  count = length(var.nodes)
  # tflint-ignore: terraform_deprecated_index
  name = format("%s-%s", var.cluster_name, var.nodes.*.name[count.index])

  kernel = local.remote_kernel
  initrd = local.remote_initrd
  args   = local.remote_args

  # tflint-ignore: terraform_deprecated_index
  generic_config = file(var.nodes.*.talos_config[count.index])

}

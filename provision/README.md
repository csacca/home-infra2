<!-- markdownlint-disable MD033 MD041 -->
<div align="center">

<!-- markdownlint-disable MD033 -->
<img src="https://raw.githubusercontent.com/siderolabs/talos/main/website/assets/icons/logo.svg" align="center" width="96px"/>

### Talos Linux cluster

... managed with Talhelper :robot:

</div>

## :book:&nbsp; Overview

This directory contains my [Talos](https://www.talos.dev/) Kubernetes cluster in declarative state.
I use [Talhelper](https://github.com/budimanjojo/talhelper) to create the `machineconfig` files of all my nodes.
The secrets are encrypted with [SOPS](https://toolkit.fluxcd.io/guides/mozilla-sops/).

---

## :scroll:&nbsp; How to apply

0. Setup local docker container of matchbox with ipxe and configure local DHCP to point to it.
1. Generate the Talos configs from `talconfig.yaml`

```bash
task talos:genconfig
```

<!-- markdownlint-disable MD029 -->
2. Load configs into matchbox

```bash
task talos:tf-apply
```

3. PXE boot nodes

```bash
task pxe:all
```

4. Bootstrap etcd on the first node:

```bash
task talos:bootstrap
```

5. Generate `kubeconfig` file:

```bash
task talos:get-kubeconfig
```

6. Deploy prerequisites: [cilium](https://cilium.io/), [kubelet-csr-approver](https://github.com/postfinance/kubelet-csr-approver):

```bash
task talos:preflux
```

7. Wipe Ceph OSD drives if needed:

```bash
task talos:wipe-rook
```

8. Install flux + reconcile cluster:

```bash
task cluster:install
```

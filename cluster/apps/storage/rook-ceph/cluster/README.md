# rook-ceph-cluster notes

``bluefs_buffered_io = false`` is required for osd-prepare task to complete.

We require manual cluster network subnet specification, no specificatio of `spec.cephClusterSpec.network` and
manual annotation of the OSD pods in order to support multus network attachment descriptions
that are based on configuration files as opposed to inline json.

```yaml
configOverride: |
  [global]
  cluster_network = 10.0.20.0/24
```

```yaml
cephClusterSpec:
  network:
```

```yaml
annotations:
  osd:
    k8s.v1.cni.cncf.io/networks: network/multus-vlan20
```

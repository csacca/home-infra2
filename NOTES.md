# Notes

## Useful `kubectl` commands

Delete all failed pods (useful after reboots):

```bash
kubectl delete pods -A --field-selector='status.phase=Failed'
```

```bash
kubectl get events --sort-by='.lastTimestamp' -A -w
```

```bash
kubectl get events --sort-by='.lastTimestamp' --field-selector type!=Normal -A -w
```

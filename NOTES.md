# Notes

## Useful `kubectl` commands

Delete all failed pods (useful after reboots):

```bash
kubectl delete pods -A --field-selector='status.phase=Failed'
```

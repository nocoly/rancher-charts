# Nocoly Rancher Charts

Official public Helm repository for deploying Nocoly HAP on Kubernetes and RKE2. It is also the upstream repository for Rancher Partner Charts.

## Repository

```bash
helm repo add nocoly https://raw.githubusercontent.com/nocoly/rancher-charts/main/
helm repo update
helm search repo nocoly/hap-nocoly-single --versions
```

Current release: `hap-nocoly-single` chart `7.3.501`, HAP `7.3.5`.

## Install

```bash
helm upgrade --install hap-nocoly-single nocoly/hap-nocoly-single \
  --namespace nocoly \
  --create-namespace \
  --set-string hap.addressMain="http://YOUR_HOST:30880" \
  --set-string hap.captainEndpoint="http://CAPTAIN_HOST:38880" \
  --set-string persistence.storageClass="local-path"
```

Adjust the endpoint, storage class, capacity, credentials, and resources for the target environment before production deployment.

`hap.apiToken` is optional. When empty, the chart generates a 32-character token on first install and reuses it on upgrades. Set `hap.apiToken` explicitly to supply or rotate the value.

## Publishing a release

1. Publish immutable container image tags.
2. Increase `version` in `Chart.yaml`; update `appVersion` and image tags.
3. Package the chart and regenerate `index.yaml` with this repository URL.
4. Verify the new package with `helm repo update` and a test installation.

Never overwrite an existing chart version. Publish corrections as a new version.

## Versioning

`appVersion` always matches the HAP version. The chart patch number is calculated as `HAP patch × 100 + chart revision`.

| HAP version | Chart revision | Chart version |
| --- | ---: | --- |
| `7.3.5` | `0` | `7.3.500` |
| `7.3.5` | `1` | `7.3.501` |
| `7.3.5` | `2` | `7.3.502` |
| `7.3.6` | `0` | `7.3.600` |
| `7.3.6` | `1` | `7.3.601` |

All catalog metadata, installation questions, and chart documentation must be written in English.

## Documentation and support

- Product: <https://www.nocoly.com>
- Deployment documentation: <https://docs-pd.nocoly.com>

export ISTIO_VERSION=1.1.4

curl -Ss https://raw.githubusercontent.com/istio/istio/${ISTIO_VERSION}/install/kubernetes/helm/helm-service-account.yaml -o config/helm-service-account.yaml
curl -Ss https://raw.githubusercontent.com/istio/istio/${ISTIO_VERSION}/install/kubernetes/helm/istio/values-istio-demo-common.yaml -o config/istio/a.yaml
curl -Ss https://raw.githubusercontent.com/istio/istio/${ISTIO_VERSION}/install/kubernetes/helm/istio/values-istio-demo.yaml -o config/istio/b.yaml

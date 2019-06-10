
# which Istio version to use must be hard coded
export ISTIO_VERSION=1.1.4

#create Istio namespace
kubectl create namespace istio-system
kubectl label namespace default istio-injection=enabled

#install tiller
curl -Ss https://raw.githubusercontent.com/istio/istio/${ISTIO_VERSION}/install/kubernetes/helm/helm-service-account.yaml | kubectl apply -f -
helm init --service-account=tiller

helm repo remove istio
helm repo add istio https://storage.googleapis.com/istio-release/releases/${ISTIO_VERSION}/charts/
helm repo update

# wait a few seconds for tiller to fully start
sleep 5
helm install istio/istio-init --namespace istio-system -n istio-init --wait

# wait a few seconds then run this command so istio-init has time to fully start
sleep 5
helm install istio/istio --namespace istio-system -n istio \
  -f https://raw.githubusercontent.com/istio/istio/${ISTIO_VERSION}/install/kubernetes/helm/istio/values-istio-demo-common.yaml \
  -f https://raw.githubusercontent.com/istio/istio/${ISTIO_VERSION}/install/kubernetes/helm/istio/values-istio-demo.yaml \
  --set global.hub=docker.io/istio \
  --set global.tag=${ISTIO_VERSION} \
  --set "kiali.dashboard.jaegerURL=http://jaeger-query:16686" \
  --set "kiali.dashboard.grafanaURL=http://grafana:3000" \
  --set global.proxy.accessLogFile="/dev/stdout"

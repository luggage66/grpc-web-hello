eval $(minikube docker-env)
docker build -t my-utility-image . -f debug.Dockerfile
kubectl delete deploy util --context minikube --namespace util
kubectl --context minikube run -i --tty --rm --namespace util util --image=my-utility-image


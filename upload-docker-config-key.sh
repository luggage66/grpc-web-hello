
# 1
kubectl create secret docker-registry docker-config \
    --docker-server "https://gcr.io" \
    --docker-username _json_key  \
    --docker-email not@val.id  \
    --docker-password="$(terraform output service_key)"

# 2
kubectl create secret generic docker-config \
    --from-file=.dockerconfigjson=/home/dmull/.docker/config.json \
    --type=kubernetes.io/dockerconfigjson

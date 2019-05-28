# docker build packages/backend-app-js -t hello-grpc-server
# docker push gcr.io/$(terraform output project_id)/hello-world:latest

docker build . -t hello-grpc-server -f backend.Dockerfile

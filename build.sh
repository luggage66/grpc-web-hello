docker build packages/backend-app-js -t gcr.io/$(terraform output project_id)/hello-world:latest
# docker push gcr.io/$(terraform output project_id)/hello-world:latest 




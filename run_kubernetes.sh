#!/usr/bin/env bash

# This tags and uploads an image to Docker Hub

# Step 1:
# This is your Docker ID/path
dockerpath=homac/udacity-cloud-devops-app

# Step 2
# Run the Docker Hub container with kubernetes
kubectl run --image=$dockerpath udacity-cloud-devops-app --port=80 --labels app=udacity-cloud-devops-app

# Step 3:
# List kubernetes pods
kubectl get pods

# Step 4:
# Wait until container is running
sleep 8
# Forward the container port to a host
kubectl port-forward deployment/udacity-cloud-devops-app 8000:80 &
# Wait until port forwarding is in place and make a prediction
sleep 5 && ./make_prediction.sh
# Get the logs
kubectl logs --selector app=udacity-cloud-devops-app
# clean up running process
kill %1

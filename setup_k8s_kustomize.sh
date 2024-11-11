#!/bin/bash

# Define environment directories and basic Kubernetes structure
ENVIRONMENTS=("staging" "production")
BASE_DIR="k8s-manifests"
APP_NAME="my-app"

# Create base directory for k8s manifests
mkdir -p "$BASE_DIR/base"

# Create base deployment YAML for kustomize
cat <<EOF > "$BASE_DIR/base/deployment.yaml"
apiVersion: apps/v1
kind: Deployment
metadata:
  name: $APP_NAME
spec:
  replicas: 1
  selector:
    matchLabels:
      app: $APP_NAME
  template:
    metadata:
      labels:
        app: $APP_NAME
    spec:
      containers:
        - name: $APP_NAME
          image: $APP_NAME:latest  # Ensure this image is built and available
          ports:
            - containerPort: 8001
EOF

# Create base service YAML for kustomize
cat <<EOF > "$BASE_DIR/base/service.yaml"
apiVersion: v1
kind: Service
metadata:
  name: $APP_NAME-service
spec:
  selector:
    app: $APP_NAME
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8001
EOF

# Create kustomization.yaml for base directory
cat <<EOF > "$BASE_DIR/base/kustomization.yaml"
resources:
  - deployment.yaml
  - service.yaml
EOF

# Create environment-specific overlays for staging and production
for env in "${ENVIRONMENTS[@]}"; do
  echo "Creating kustomize overlay for $env environment..."
  mkdir -p "$BASE_DIR/overlays/$env"

  # Create environment-specific kustomization.yaml
  cat <<EOF > "$BASE_DIR/overlays/$env/kustomization.yaml"
resources:
  - ../../base

# Patches for $env environment
patchesStrategicMerge:
  - replica-patch.yaml
EOF

  # Create replica patch file for the environment
  cat <<EOF > "$BASE_DIR/overlays/$env/replica-patch.yaml"
apiVersion: apps/v1
kind: Deployment
metadata:
  name: $APP_NAME
spec:
  replicas: $(if [ "$env" = "production" ]; then echo 3; else echo 2; fi)
EOF

done

echo "Kustomize setup for My_app project complete."


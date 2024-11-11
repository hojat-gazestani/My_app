# My_app
## Microservice project

```bash
git clone https://github.com/hojat-gazestani/My_app.git && cd My_app/
source myapp/bin/activate

cd myproject
docker build  -t my_app .
docker run -d --hostname Myapp10 -p 8010:8001 my_app
docker run -d --hostname Myapp11 -p 8011:8001 my_app
docker run -d --hostname Myapp12 -p 8012:8001 my_app
```

## Kubernetes project YAML files using `kustomize`

```sh
# For staging environment
kubectl apply -k k8s-manifests/overlays/staging

# For production environment
kubectl apply -k k8s-manifests/overlays/production
```

1. Base Configurations:

* **base/deployment.yaml:** Defines the basic deployment configuration for my-app.
* **base/service.yaml:** Creates a Service to expose the my-app container on port 80, targeting container port 8001.
* **base/kustomization.yaml:** Includes the base deployment and service YAML files.

2. Environment-Specific Overlays:

* **overlays/staging/kustomization.yaml** and **overlays/production/kustomization.yaml:** Each overlay refers to the base configuration and applies an environment-specific `replica-patch.yaml`.
* **replica-patch.yaml:** Adjusts the `replicas` count based on the environment (e.g., `2` for staging and `3` for production).

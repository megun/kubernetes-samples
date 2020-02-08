# install
```
kubectl apply -f ./serviceaccount.yaml

helm install --namespace kube-system -f config.yaml external-secrets external-secrets/kubernetes-external-secrets
```


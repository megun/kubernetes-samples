
# install
```
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

# argo cd cli
```
brew tap argoproj/tap
brew install argoproj/tap/argocd
```

# 初期パスワード
```
kubectl get pods -n argocd -l app.kubernetes.io/name=argocd-server -o name | cut -d'/' -f 2
```

# port forward
```
kubectl port-forward svc/argocd-server -n argocd 8080:443
```


# external-secrets入れる



# cluster追加
argocd login localhost:8080
kubectl config get-contexts
argocd cluster add xxx



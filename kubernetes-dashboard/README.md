# 前提
- metrics-serverが必要

# インストール
```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta4/aio/deploy/recommended.yaml
```

# 接続用のServiceAccountとClusterRoleBinding作る
```
kubectl apply -f eks-admin-service-account.yaml
```

# 接続
- token取得
```
kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep eks-admin | awk '{print $1}')
```

- proxy起動
```
kubectl proxy
```

- ブラウザから接続
http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#!/login
トークンでログイン
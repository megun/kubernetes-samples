- ノードグループのASGにタグつける(valueは何でもいい)
```
k8s.io/cluster-autoscaler/cluster-001: owned
k8s.io/cluster-autoscaler/enabled: true
```

- deploy
```
kubectl apply -f ./
```

- pod増やして確認
```
kubectl create deployment autoscaler-demo --image=nginx
kubectl scale deployment autoscaler-demo --replicas=50
```

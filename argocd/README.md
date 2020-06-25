
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
argocd cluster add hironori@cluster-001.ap-northeast-1.eksctl.io



gitopsなのでimageのバージョンをmanifest書き込むのが推奨っぽい
overrideはできるけど、自動で判別するの無理。
コマンドまたはUIからやるしかない
argocd app set guestbook -p guestbook=image=example/guestbook:abcd123
argocd app sync guestbook
他の例をみても、CI回した後にイメージがプッシュされてそのイメージタグでgitに直コミットまたはPRするパターンが多い。

１つのアプリケーションで複数のネームスペースにまたがってのデプロイができなさそう。
istio-systemとsettlnetio-jpyを一緒にとか無理そう



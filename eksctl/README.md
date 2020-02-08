# cluster.yamlについて
terraformから作成してる(../terraform/template.tf)

# インストール

* AWS CLI 最新にする
```
pip install awscli --upgrade --user
```

* aws認証情報設定する

* eksctlインストール(homebrew)
```
brew tap weaveworks/tap
brew install weaveworks/tap/eksctl
```

* eksctlアップデート
```
brew upgrade eksctl && brew link --overwrite eksctl
```

* 確認
```
eksctl version
```

# EKSクラスタ作成(15-20分くらいかかる)
## 何も考えずとりあえず作る
```
eksctl create cluster
```

## yamlから作成
```
eksctl create cluster -f cluster.yaml
```

# ノードグループ管理
## スケールアウト
- ノードグループng-1-workersのdesiredを3にする
```
eksctl scale nodegroup --cluster=cluster-001 --nodes=3 ng-1-workers
```

# EKSクラスタアップデート
## コントロールプレーンのアップデート
```
eksctl update cluster -n cluster-001
```

## ノードグループのアップデート
* 今の情報確認
```
eksctl get nodegroups --cluster=cluster-001
```

* 新ノードグループ追加
```
eksctl create nodegroup --cluster=cluster-001
```

* 旧ノードグループ削除
```
eksctl delete nodegroup --cluster=<clusterName> --name=<oldNodeGroupName>
```

# EKSクラスタ削除
## クラスタ全削除
```
eksctl delete cluster -n cluster-001
```

## ノードグループ削除
```
eksctl delete nodegroup --cluster=cluster-001 --name=ng-1-workers
```

## ポッドのドレイン
```
eksctl drain nodegroup --cluster=<clusterName> --name=<nodegroupName>
```

## ポッドのドレイン解除
```
eksctl drain nodegroup --cluster=<clusterName> --name=<nodegroupName> --undo
```

# サービスアカウントとIAMロール紐付け
```
IAM OIDCプロバイダー有効化
eksctl utils associate-iam-oidc-provider --config-file=cluster.yaml --approve

サービスアカウントとIAMロール作成
eksctl create iamserviceaccount --config-file=cluster.yaml --override-existing-serviceaccounts --approve

削除
eksctl delete iamserviceaccount --config-file=cluster.yaml --only-missing --approve
```

# faragete-profile
## profile作成
```
eksctl create fargateprofile -f cluster.yaml
```

## 確認
```
eksctl get fargateprofile --cluster cluster-001
　
eksctl get fargateprofile --cluster cluster-001 -o yaml

eksctl get fargateprofile --cluster cluster-001 -o json
```

## 削除
```
eksctl delete fargateprofile --cluster cluster-001 --name fp-dev --wait
```

# Cloudwatchロギング
```
eksctl utils update-cluster-logging --config-file=cluster.yaml
```

# gitops
##  初期設定
- fluxマニフェストをgitにpushして、fluxやらhelmやらなんやかんやをデプロイしてる
```
EKSCTL_EXPERIMENTAL=true eksctl enable repo -f cluster.yaml --git-url=git@github.com:megun/kubernetes-samples.git --git-email=akamarl.1127@gmail.com
```
- 結果表示された公開鍵をgit追加(リポジトリ読み書きできるようにする(タグ更新できればいいっぽい？))
- pod確認
```
kubectl get pods -A
```

## サンプルデプロイ
```


EKSCTL_EXPERIMENTAL=true eksctl \
        enable profile \
        --git-url git@github.com:megun/kubernetes-samples.git \
        --git-email akamarl.1127@gmail.com \
        --cluster cluster-001 \
        --region ap-northeast-1 \
        app-dev
```
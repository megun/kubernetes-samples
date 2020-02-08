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


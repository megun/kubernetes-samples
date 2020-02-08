# install
```
brew install helm
```
v3でtillerがいらなくなったっぽい

# リポジトリ
## リポジトリ追加
- ローカルリポジトリに追加
```
helm repo add stable https://kubernetes-charts.storage.googleapis.com/
```

## リポジトリ確認
- ローカルに追加したリポジトリ検索
```
helm search repo
```

- ローカルに追加したstable含むリポジトリを検索
```
helm search repo stable
```

- ローカルに設定されてるリポジトリ一覧
```
helm repo list
```

## アップデート
```
helm repo update
```

# チャート
## インストール
- `stable/mysql` インストールしてリリース名は自動付与
```
helm install stable/mysql --generate-name
```

- `stable/mysql` インストールしてリリース名はhoge001
```
helm install hoge001 stable/mysql
```

- 設定可能なパラメータ確認して、必要なパラメータ上書きしてインストール(mariadbUserとmariadbDatabaseを変更してる)
```
helm show values stable/mariadb

echo '{mariadbUser: user0, mariadbDatabase: user0db}' > config.yaml
helm install -f config.yaml stable/mariadb --generate-name
```

## 確認
- デプロイされた全てのリリース確認
```
helm ls
```

- hoge001の状態確認
```
helm status hoge001
```

- kubernetes-dashboardをhubから検索
```
helm search hub kubernetes-dashboard
```

## アップデート
```
helm upgrade hoge001 stable/external-dns
```

## アンインストール
- hoge001アンインストール
```
helm uninstall hoge001
```


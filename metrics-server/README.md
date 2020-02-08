# isntall
- helmから
```
helm install stable/metrics-server --generate-name -f ./config.yaml -n kube-system
```

- マニフェスト落としてきてインストール
```
DOWNLOAD_URL=$(curl -Ls "https://api.github.com/repos/kubernetes-sigs/metrics-server/releases/latest" | jq -r .tarball_url)
DOWNLOAD_VERSION=$(grep -o '[^/v]*$' <<< $DOWNLOAD_URL)
curl -Ls $DOWNLOAD_URL -o metrics-server-$DOWNLOAD_VERSION.tar.gz
mkdir metrics-server-$DOWNLOAD_VERSION
tar -xzf metrics-server-$DOWNLOAD_VERSION.tar.gz --directory metrics-server-$DOWNLOAD_VERSION --strip-components 1

下記を追記ないと kubectl top node が使えないかも
        args:
        - --kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname

kubectl apply -f metrics-server-$DOWNLOAD_VERSION/deploy/1.8+/
```

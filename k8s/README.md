# ローカルk8s (無しでも可)
0. minikube start && minikube dashboard

# namespace 追加
`k create -f namespace/`

# mysql deployment 作成
`k create -f deployment/mysql.yml`

# mysql service 作成
`k create -f service/mysql.yml`

# go-next_development DB 作成
pod 一覧を取得する
`k get pods -n go-next`

mysql podに入る
`k exec mysql-7849556fb7-drkwg -n go-next -it -- bash`

# mysql 設定環境編を作成する
`k create -f config/go.yml`

# go で DB migration を行う (job 実行)
`k create -f job/go.yml`

# go deployment 作成
`k create -f deployment/go.yml`

# go service 作成
`k create -f service/go.yml`

# next deployment 作成
`k create -f deployment/next.yml`

# next service 作成
`k create -f service/next.yml`

# ingress 作成
`k create -f k8s/ingress.yml`


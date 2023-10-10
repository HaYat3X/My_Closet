# ファッションアプリ「MY CLOSET」
「MY CLOSET」の機能やサイトは下記の外部リンクで紹介していますので、そちらをご覧ください。

## インストール方法
以下のコマンドを使用してプロジェクトをインストールすることができます。

### 1、Dockerのインストール
[Dockerのインストールはこちら](https://matsuand.github.io/docs.docker.jp.onthefly/get-docker/)

### 2、各コマンドの実行
```
git clone https://github.com/Hayate12345/My_Closet
```

```
cd My_Closet
```

```
.env.exampleファイルを参考に.envファイルを作成
```

```
docker compose run --no-deps web sh
```

```
apk update && apk add --no-cache --virtual .build-dependencies build-base postgresql-dev && bundle install && rails webpacker:install && apk del .build-dependencies
```

```
exit
```

```
docker compose build --no-cache
```

```
docker compose up
```

```
docker compose exec web rails db:create
```

```
http://localhost:3000
```

## 外部リンク
[「MY CLOSET」はこちら](https://frozen-cove-82653-5359138e2ddd.herokuapp.com/)

[ドキュメントはこちら](https://drive.google.com/drive/folders/1sXxRJCKHu9ZKTcSRYNvJITtDsIrKztMP)
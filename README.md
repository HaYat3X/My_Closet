- 環境構築方法
  - Docker デスクトップのインストール
  - このリポジトリを Git_clone する
  - ターミナルを開きクローンしたフォルダに移動
  - .envファイルを作成（とげを呼ぶ）
  - $docker compose run --no-deps web sh
  - $apk update && apk add --no-cache --virtual .build-dependencies build-base postgresql-dev && bundle install && rails webpacker:install && apk del .build-dependencies
  - $exit
  - $docker compose build --no-cache
  - $docker compose up（コンテナ起動）
  - $docker compose exec web rails db:create（コンテナ起動時にコマンドを打たないとダメ）
  - http://localhost:3000 にアクセス

** ※ファイル更新したら際ビルド必要
docker compose run --no-deps web sh
apk update && apk add --no-cache --virtual .build-dependencies build-base postgresql-dev && bundle install && rails webpacker:install && apk del .build-dependencies
docker compose build --no-cache
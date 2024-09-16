# railwayデプロイで詰まったこと

## Dockerfileの見直し
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
上記パッケージを追加しないと一向にrailsサーバーが立ち上がらない。

## DBとの接続
DBサーバーも立ち上げよう。

## 環境変数
環境変数で**RAILS_ENV**に`production`を設定しよう。
明示的に設定しないとdev環境に向いちゃう

## hostの設定

config.hosts << "railsapitester-production.up.railway.app"

hostの設定は`/app/config/application.rb`と`/app/config/environments/production.rb`に必要
FROM ruby:3.1

# アプリケーションディレクトリを作成
WORKDIR /app

# 必要なパッケージをインストール
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# GemfileとGemfile.lockをアプリケーションディレクトリにコピー
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

# Bundlerを使って依存関係をインストール
RUN bundle install

# アプリケーションのソースコードをコピー
COPY . /app

# サーバーを起動するためのコマンド
CMD ["rails", "server", "-b", "0.0.0.0", "-p", "3000"]

# concourse-buildpacks

## これはなに

- Conoucorseのタスク内でbuildpacksを動かすためのイメージ
  - buildpacksの動作条件
    - docker daemonが起動していること
      - Concourseのタスクはコンテナ上でうごいている
      - その上で新たなコンテナを起動したい
      - 👉 Docker in Docker
- [cycloid/concourse-dind](https://hub.docker.com/r/cycloid/concourse-dind)がメンテされていて、一番うまいこと動いている
  - これをベースにjdkとpackコマンドをインストールすればConcourseでbuildpacksが動くイメージを作ることが出来る
    - 追加でインストールするモジュール
      - jdk
        - openjdk17
      - [packコマンド](https://github.com/buildpacks/pack/releases)

## build

### 必要なツール

- make
- docker
- [buildx](https://matsuand.github.io/docs.docker.jp.onthefly/buildx/working-with-buildx/)

### つかいかた

- [Makefile](Makefile)にbuildにひつような処理を記載している
- 環境依存値は`.env`からロードする
- [.env.sample](./.env.sample)は定義する環境依存値のサンプル

#### はじめに

```sh
# 環境依存値を記載する
cp .env.sample .env
vi .env
```

#### コンテナイメージのbuild/push

```sh
make
```

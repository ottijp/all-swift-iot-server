# all-swift-iotのサーバモジュール

Vaporを使い，デバイス状態を管理します．

## 環境

* Swift 4.2
* Vapor 3.0

## 環境変数

* DATABASE_URL: 接続先のPostgreSQLのURL

## 実行方法

```
$ vapor run
```

## デプロイ方法

```
$ vapor heroku init
$ git push heroku master
```

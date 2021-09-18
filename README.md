# お話し会「おひさま」活動記録アプリ
お話し会おひさまのための活動記録管理アプリです。
ユーザーは会所有の蔵書を登録＆確認し、読み聞かせ活動の記録を作成することができます。

## 注意点
実際にお話し会「おひさま」で使用されているアプリケーションのため、誰でもログインはできない仕組みになっています。
  
そのため、詳細に使用画面と機能を記載します。

## URL
https://onagawaohisama.com

## 作成した目的
「いつもワードで作っていたお話し会の活動記録を簡単に作成できるようにしたい」
「お話し会の蔵書をメンバーがいつでも手元で確認できるようにしたい」
という母の抱えていた問題を解決するために作成した。

## 使用画面と機能
| ログインページ | 活動記録一覧ページ |
| :--- | :--- |
| [![Image from Gyazo](https://i.gyazo.com/cd3dbd9ad93a4b53230105109a2d15ed.png)](https://gyazo.com/cd3dbd9ad93a4b53230105109a2d15ed) | [![Image from Gyazo](https://i.gyazo.com/4865d4c9d318fab1ab72ca56cc631950.png)](https://gyazo.com/4865d4c9d318fab1ab72ca56cc631950) |
| メールアドレスとパスワードでログインする | これまでの活動記録を検索できる |
  
| 活動記録の投稿ページ | ユーザー一覧ページ |
| :--- | :--- |
| [![Image from Gyazo](https://i.gyazo.com/1956782160ccce315f5795c8d876792d.png)](https://gyazo.com/1956782160ccce315f5795c8d876792d) | [![Image from Gyazo](https://i.gyazo.com/8f560205687689d44d5d21bfd2d44d85.png)](https://gyazo.com/8f560205687689d44d5d21bfd2d44d85) |
| 読んだ絵本をモーダル表示する | ユーザーの一覧を表示する。管理者ユーザーのみユーザーの削除ができる。 |
  
| ユーザーの招待ページ | ユーザー編集ページ |
| :--- | :--- |
| [![Image from Gyazo](https://i.gyazo.com/60cc7a5913e7574e520239238088086e.png)](https://gyazo.com/60cc7a5913e7574e520239238088086e) | [![Image from Gyazo](https://i.gyazo.com/7aeb8cdc6baa0344fd9242f47badcefc.png)](https://gyazo.com/7aeb8cdc6baa0344fd9242f47badcefc) |
| 管理者ユーザーのみアクセスできる。招待する方のメールアドレスを入力し招待ボタンを押すと、招待リンクが書かれたメールが送信される。 | ユーザーの名前を編集できる |
  
| 蔵書一覧ページ | 蔵書の新規登録ページ |
| :--- | :--- |
| [![Image from Gyazo](https://i.gyazo.com/85dc532da8e2bea34ecd0a38cf7a458c.png)](https://gyazo.com/85dc532da8e2bea34ecd0a38cf7a458c) | [![Image from Gyazo](https://i.gyazo.com/0b00e2862ebb2517840effdcd9792f6e.png)](https://gyazo.com/0b00e2862ebb2517840effdcd9792f6e) |
| おひさま会の蔵書を検索できる | 新しい蔵書を登録できる |

## 使用技術

* Ruby 3.0.2
* Ruby on Rails 6.1.4
* MySQL2
* AWS
  * EC2
  * RDS
  * route53
* GoogleBooksAPI

## ER図
[![Image from Gyazo](https://i.gyazo.com/b440604d0257e882fae79234af4a5e97.png)](https://gyazo.com/b440604d0257e882fae79234af4a5e97)


# お話し会「おひさま」活動記録アプリ
お話し会おひさまのための活動記録管理アプリです。
ユーザーは会所有の蔵書を登録＆確認し、読み聞かせ活動の記録を作成することができます。

## こだわったポイント
・過去に読んだ本をすぐに思い出せるように、活動記録の検索機能を実装しました。
・絵本を手軽に登録できるように、GoogleBooksAPIと非同期処理を用いて、絵本の検索、登録機能を実装しました。
・小さなコミュニティだけで利用するアプリケーションのため、不特定多数によるユーザー登録ができないようにユーザーの招待機能を実装しました

## 注意点
実際にお話し会「おひさま」で使用されているアプリケーションのため、本番環境はログインはできない仕組みになっています。

閲覧用のURLから、ゲストユーザーでログインをお願いします。

## URL
本番環境
  
https://onagawaohisama.com

閲覧用（heroku)
  
https://onagawaohisama.herokuapp.com
 
ゲストユーザー

email: guest@example.com

password: password

## 作成した目的
「いつもワードで作っていたお話し会の活動記録を簡単に作成できるようにしたい」

「お話し会の蔵書をメンバーがいつでも手元で確認できるようにしたい」

という母の抱えていた問題を解決するために作成しました。  

## 使用画面と機能
| ログインページ | ユーザー登録ページ |
| :--- | :--- |
| [![Image from Gyazo](https://i.gyazo.com/cd3dbd9ad93a4b53230105109a2d15ed.png)](https://gyazo.com/cd3dbd9ad93a4b53230105109a2d15ed) | [![Image from Gyazo](https://i.gyazo.com/281a204374054eccdceb39551c7076a9.png)](https://gyazo.com/281a204374054eccdceb39551c7076a9) |
| メールアドレスとパスワードでログインする | ユーザーの新規登録ができる |

| 活動記録一覧ページ | 活動記録詳細ページ |
| :--- | :--- |
| [![Image from Gyazo](https://i.gyazo.com/4865d4c9d318fab1ab72ca56cc631950.png)](https://gyazo.com/4865d4c9d318fab1ab72ca56cc631950) | [![Image from Gyazo](https://i.gyazo.com/11ad1084751ce4c45056174926f06366.png)](https://gyazo.com/11ad1084751ce4c45056174926f06366) |
| これまでの活動記録を検索できる | 活動記録の詳細を見ることができる |
  
| 活動記録の投稿ページ | ユーザー一覧ページ |
| :--- | :--- |
| [![Image from Gyazo](https://i.gyazo.com/1956782160ccce315f5795c8d876792d.png)](https://gyazo.com/1956782160ccce315f5795c8d876792d) | [![Image from Gyazo](https://i.gyazo.com/8f560205687689d44d5d21bfd2d44d85.png)](https://gyazo.com/8f560205687689d44d5d21bfd2d44d85) |
| 活動記録を投稿することができる。 | ユーザーの一覧を表示する。管理者ユーザーのみユーザーの削除ができる。 |
  
| ユーザーの招待ページ | ユーザー編集ページ |
| :--- | :--- |
| [![Image from Gyazo](https://i.gyazo.com/60cc7a5913e7574e520239238088086e.png)](https://gyazo.com/60cc7a5913e7574e520239238088086e) | [![Image from Gyazo](https://i.gyazo.com/7aeb8cdc6baa0344fd9242f47badcefc.png)](https://gyazo.com/7aeb8cdc6baa0344fd9242f47badcefc) |
| 管理者ユーザーのみアクセスできる。招待する方のメールアドレスを入力し招待ボタンを押すと、招待リンクが書かれたメールが送信される。 | ユーザーの名前を編集できる |
  
| 蔵書一覧ページ | 蔵書の新規登録ページ |
| :--- | :--- |
| [![Image from Gyazo](https://i.gyazo.com/85dc532da8e2bea34ecd0a38cf7a458c.png)](https://gyazo.com/85dc532da8e2bea34ecd0a38cf7a458c) | [![Image from Gyazo](https://i.gyazo.com/0b00e2862ebb2517840effdcd9792f6e.png)](https://gyazo.com/0b00e2862ebb2517840effdcd9792f6e) |
| タイトル、著者名、出版社名からおひさま会の蔵書を検索することができる。 | 新しい蔵書を登録することができる。キーワードを入力して検索ボタンを押すと、候補が表示されて登録ができる。|

## 使用技術 

* Ruby 3.0.2
* Ruby on Rails 6.1.4
* MySQL
* Nginx
* Puma
* AWS
  * VPC
  * EC2
  * RDS
  * route53
  * S3
* GoogleBooksAPI

## ER図
[![Image from Gyazo](https://i.gyazo.com/e57d8f74a3274121a8c3e796a89bfdb6.png)](https://gyazo.com/e57d8f74a3274121a8c3e796a89bfdb6)


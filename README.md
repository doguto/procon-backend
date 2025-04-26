# Programming Contest 2025

## Front End
https://github.com/tsukuneA1/procon-frontend

## Develop Rules
### Package manager
新規にライブラリを追加した際は以下のコマンドの打ち忘れに注意。
```
bundle install
```
### Linter
GitHubへとPushする前に必ず以下のコマンドを実行し、Linterを通しましょう。
```
bundle exec rubocop -a
```
Linterでoffenseが出た場合は修正してからPushするようにしてください。

また、GitHubのプルリクエスト時にActionがFailした場合は大抵Linterに引っかかってます。その場合も再度確認してください。




## Default document

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

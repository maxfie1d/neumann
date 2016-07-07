# neumann package
[![apm](https://img.shields.io/apm/v/neumann.svg)](https://atom.io/packages/neumann)
[![apm](https://img.shields.io/apm/dm/neumann.svg)](https://atom.io/packages/neumann)
[![apm](https://img.shields.io/apm/l/neumann.svg)](https://atom.io/packages/neumann)

gitの履歴からバグの発見を支援するツール(になる予定)です。

# 開発ルール

## 議事録
議事録はディレクトリdoc/meeting_minute内に保存してください。Markdown形式で保存していただけるとありがたいです。

## 情報共有
このプラグインに関する情報交換やバグの報告は全てissueで行ってください。

## Pull Request
コードを他人にレビューして欲しい時はPull Requestを作成してください。

## 文字コード
文字コードは**UTF-8**で統一してください。

## インデントについて
インデントはスペースではなくタブ文字に統一します．
Atomの場合，「Settings」の下の方に「Tab Type」という項目があるので，これを「hard」に設定してください．

## ブランチ戦略
作業に応じたブランチでcommitしてください。ブランチ戦略は[Driessen](http://nvie.com/posts/a-successful-git-branching-model/)(英語注意．日本語訳は[ここ](http://keijinsonyaban.blogspot.jp/2010/10/successful-git-branching-model.html))の方法で行おうと思います。

ざっくりと説明すると、
<dl>
	<dt>master</dt>
	<dd>安定版のリリース</dd>
	<dt>release</dt>
	<dd>最新版のリリース。特定のバージョンを安定版にするときはmasterにmergeしてください。</dd>
	<dt>hotfixes</dt>
	<dd>重大なバグの修正。修正したあとはmasterとhotfixesにmergeしてください。</dd>
	<dt>develop</dt>
	<dd>開発用。機能が実装できて動作が確認できればreleaseにmergeしてください。</dd>
	<dt>feaature</dt>
	<dd>特定の機能開発をするごとに新たに作成するブランチです。機能の開発が終了したらdevelopに**rebase**(≠merge)してください。</dd>


## gitの基本的な使い方
<dl>
	<dt>編集したファイルを追加</dt>
	<dd>git add (ファイル名)</dd>
	<dt>コミット</dt>
	<dd>git commit -m "(コミットメセージ)"</dd>
	<dt>プッシュ</dt>
	<dd>git push</dd>
	<dt>ブランチの切り替え</dt>
	<dd>git checkout (ブランチ名)</dd>
	<dt>コミッター・タイムスタンプ表示</dt>
	<dd>git blame (ファイル名)</dd>

## Collaborators
いきなりpushは怖いという人はここに自己紹介でも書いて練習しましょう！

<dl>
	<dt>[MaxfieldWalker](https://github.com/MaxfieldWalker)
	<dd>Web周りの技術にも興味あります．CoffeeScriptは初心者です．好きなコーヒーはアイスコーヒーです．よろしくお願いします．
	<dt>[MasayoshiIwamoto](https://github.com/MasayoshiIwamoto)
	<dd>プログラミングは好きですが、プログラミングの勉強は嫌いです.頑張らない僕を叱って下さい.好きな言葉は「マヨネーズ」です.よろしくお願いします.
	<dt>[igaigai](https://github.com/igaigai)
	<dd>プログラミングは好きですが、勉強は嫌いです。好きな役は純チャンです。わからないことばかりですが、よろしくお願いします.
	<dt>[tarohi24](https://github.com/tarohi24)
	<dd>プログラミングは好きです。勉強も好きです。好きなvimはvimです。よろしくお願いします。
	<dt>[Keigo01](https://github.com/Keigo01)
	<dd>プログラミングは好きです。最近はデザイン関係も面白そうだなと思っています。よろしくお願いします。

# neumann packag

gitの履歴からバグの発見を支援するツールです。

# 開発ルール

## 議事録
議事録はディレクトリdoc/meeting_minute内に保存してください。Markdown形式で保存していただけるとありがたいです。

## 情報共有
このプラグインに関する情報交換やバグの報告はは全てissueで行ってください。

## Pull Request
コードを他人にレビューして欲しい時はPull Requestを作成してください。

## ブランチ戦略
作業に応じたブランチでcommitしてください。ブランチ戦略は[Driessen](http://nvie.com/posts/a-successful-git-branching-model/)の方法で行おうと思います。

ざっくりと説明すると、
<dl>
	<dt>master</dl>
	<dd>安定版のリリース</dd>
	<dt>release</dt>
	<dd>最新版のリリース。特定のバージョンを安定版にするときはmasterにマージしてください。</dd>
	<dt>hotfixes</dt>
	<dd>重大なバグの修正。修正したあとはmasterとhotfixesにマージしてください。</dd>
	<dt>develop</dt>
	<dd>開発用。機能が実装できて動作が確認できればreleaseにマージしてください。</dd>
	<dt>feaatureブランチ*</dt>
	<dd>特定の機能開発をするごとに新たに作成するブランチです。機能の開発が終了したらdevelopにrebaseしてください。</dd>
<\dl>


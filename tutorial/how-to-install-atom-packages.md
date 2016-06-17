# Atomのパッケージのインストール方法

通常Atomのパッケージは「Settings」→「Install」から簡単にインストールできますが，今回は自前でパッケージを作っているので，手動インストール？を行います．


## 手順

1. パッケージがインストールされるディレクトリを調べます．
「Settings」→「Install」と進むとパッケージ検索の上にパッケージがインストールされるディレクトリが表示されています．
![](https://github.com/MaxfieldWalker/neumann/wiki/img/how-to-install-atom-packages/atom-package-install-dir.jpg)


1. ターミナルを開いて先ほど調べたディレクトリに移動し，GitHubからリポジトリをクローンしてきます．

  ```
  $ cd "パッケージがインストールされるディレクトリ"
  $ git clone https://github.com/MaxfieldWalker/neumann.git
  ```

1. developブランチに最新のコミットがあるので取り込みます．

	```
	$ git fetch origin develop
	$ git checkout -b develop origin/develop
	```

1. Atomを`Ctrl`+`Alt`+`R`でリロードします．

1. neumannの機能が利用できるようになっているはずです．
「Packages」→「neumann」があるか確認してみましょう．
![](https://github.com/MaxfieldWalker/neumann/wiki/img/how-to-install-atom-packages/neumann-is-successfully-installed.jpg)

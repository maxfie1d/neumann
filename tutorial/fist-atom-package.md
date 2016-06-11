# 単語数カウントパッケージの作り方

*Windows版Atomで説明しています．Mac版はショートカットキー等が異なると思うので気をつけてください～*

1. **重要**
Ctrl + ,(コンマ) で設定画面を開いて左側のメニューから「Packages」を押し，「package-generator」で検索して，「ppackage-generator」の「Package Syntax」の設定を「coffeescript」にします．
![](https://github.com/MaxfieldWalker/neumann/wiki/img/first-atom-package/package-generator-settings.jpg)

1. Ctrl + Shift + Pでコマンドパレットを開き，「generate」で検索すると「Package Generator: Generate Package」が出てくるので選択してEnter．
![](https://github.com/MaxfieldWalker/neumann/wiki/img/first-atom-package/generate-package.jpg)

1. かっこいいパッケージ名を入力してEnter．
![](https://github.com/MaxfieldWalker/neumann/wiki/img/first-atom-package/enter-package-path.jpg)

1. パッケージが作成されます．
![](https://github.com/MaxfieldWalker/neumann/wiki/img/first-atom-package/package-generated.jpg)

1. Ctrl + Alt + RでAtomをリロードします．その後「Package」メニューを開くとさっそく作成したパッケージが表示されています．
![](https://github.com/MaxfieldWalker/neumann/wiki/img/first-atom-package/word-count-menu.jpg)

1. 試しに「Toggle」を押して見ると何やらポップアップが出てきます．
![](https://github.com/MaxfieldWalker/neumann/wiki/img/first-atom-package/word-count-popup.jpg)

1. とりあえずHello World的なことができました．次はこのポップアップに現在開いているファイルに含まれる単語数を表示するようプログラムを書き換えましょう．

1. 続きは公式ドキュメントで．英語ですが，とりあえずコードの部分だけ辿ればOK．
[Package: Word Count](http://flight-manual.atom.io/hacking-atom/sections/package-word-count/)

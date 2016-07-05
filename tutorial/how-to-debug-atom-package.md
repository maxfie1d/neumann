# Atomのパッケージのデバッグ

## console.logを使う方法
`console.log`はC言語でいうと`printf`関数的な存在で変数などの値をコンソールに出力することができます．

```coffeescript
# アニメーションの長さ
duration = 1500

console.log duration
```
そして，コンソールというのはAtomの場合`Ctrl`+`Alt`+`I`でインスペクタ画面を開いて「Console」タブで見ることができます．

![](https://github.com/MaxfieldWalker/neumann/wiki/img/how-to-debug-atom-package/inspector.jpg)

さらに，CoffeeScriptの機能で文字列に変数などを埋め込むことができるので

```coffeescript
# アニメーションの長さ
duration = 1500
# アニメーションのディレイ
delay = 50
# 棒の縦幅
barHeight = 24

console.log "duration: #{duration}, delay: #{delay}, barHeight: #{barHeight}"
```

としてやると

```
duration: 1500, delay: 50, barHeight: 24
```

と表示されます．便利！

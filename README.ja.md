# neumann package
[![apm](https://img.shields.io/apm/v/neumann.svg)](https://atom.io/packages/neumann)
[![downloads](https://img.shields.io/apm/dm/neumann.svg)](https://atom.io/packages/neumann)
[![license](https://img.shields.io/apm/l/neumann.svg)](https://atom.io/packages/neumann)

neumannはGitの変更履歴からバグの危険のあるコードの発見を支援する[Atom](https://atom.io/)のパッケージです．

## 使い方
### バグの危険のあるコードを可視化する
command: `neumann:suspicious-lines`

赤くなっているコードほど，よりバグの危険のあるコードです．

![Suspicious lines](https://github.com/MaxfieldWalker/neumann/wiki/gif/suspicious-lines.gif)

### 疑わしさの棒グラフを表示する
command: `neumann:suspiciousness-graph`

![Suspiciousness graph](https://github.com/MaxfieldWalker/neumann/wiki/gif/suspiciousness-graph.gif)

## 仕組み
### ノイマンアルゴリズム
neumannはバグの危険のあるコードを発見するために**ノイマンアルゴリズム**というアルゴリズムを使用しています．
**ノイマンアルゴリズム**はいくつかの素晴らしいルールに沿ってコードを評価します．
<dl>
    <dt>深夜ルール</dt>
        <dd>夜に書かれたコードは疑わしいです．</dd>
    <dt>信頼できない人ルール</dt>
        <dd>信頼できない人が書いたコードは疑わしいです．</dd>
    <dt>編集履歴ルール</dt>
        <dd>新しく編集されたコードほど疑わしいです．</dd>
    <dt>未コミットルール</dt>
        <dd>未コミットのコードなら通知します．</dd>
</dl>


## 要件
### 対応プラットフォーム
- Windows
- Mac
- Linux

## インストール
```
$ apm install neumann
```

もしくは

1. [Atom](https://atom.io/)でSettings(設定)を開きます (Windows: `Ctrl`+`,` Mac: `⌘`+`,`)
- Install(インストール)へ移動します
- `neumann`を検索します
- インストールします

## Contribution
1. フォークします
- フィーチャーブランチを作成します (`git checkout -b new-feature`)
- 変更を加えます
- 変更をコミットします (`git commit -am '素晴らしいフィーチャーを追加しました'`)
- ブランチをプッシュします (`git push origin new-feature`)
- プルリクエストを作成します

## ライセンス
[MIT](LICENSE.md)

## 彼の名はノイマン
```
#HHHH@@@@@gmqkkbppfffVyyyyZZZZuvvrrrtttOtrrvvzzzXuZZZyyyVfVfpppbbbbppfpffpffffff
#H#HHHHH@@@gmqkbppffffVyyyyZXuZwOwmQQmgmHMMMNNHkwZXXZZyyyVVfppppppppfpppffpffVff
HHHHHHHHHH@@gmkbpppffVVyyyZUzzI+j+XHHMMMMHHHHHUIwWMHHkkkyyVVffpfVyVVfppfpfffffff
HH######HHH@@gqkbppffVyXZXWX&uAwXHHHHHSVVTC1<?<<OWHHHMMMNkyVVfffVVyfppppffppfffp
##NNNN#N##HH@@mqbppffXCdWHW0zz?OOdXXWkO1<<___` `_1XWH@MMMNNkyVVVVVffffpppppfpppf
NNNNNNNNN#HH@@gqHpp06jdHS<<:(<<+zOOwOOI<__  ````` _?XHHHMMMMNWVyyVfffppfpfppffff
NNNNNNNNN##HH@gHkW6+dWHC~(+1zzzlzO<<<<~<_ ` `    `` ?XHMMMMMNNkyyyVVVffppffpffff
NNNNNNNN#N##HHHWY1dWM@<(+<1<zOOz<~<_.    ``    ` ` ``_vHgqMNMMMkyZyyyVffpffffffV
NNNNNNN#NN##HMHP.OWM#> _<+;<<<<<~~_  ```   ` `    ` `` ?MHMMHM##NZZyyyVVVfffffVV
NNNNNNNN###HHMM{ (MM$  -+?<:~._.` `````  `           ```zWMMMHM#MHkZZyyyVVyVVyVy
NN#NNN####H#HHH-. WM!  (=<<~..````````` ` `      `   ``` zXHMHMMNNMXuZZZZyyyyyyy
NNNN#######HMN8<-(}   .;=<:_..``````   `   `  `   `   ```(UMHMHMNMKzzuuuZuZZZZZZ
N#######HHHHHB<_.d{ ` (<=>:_.````  ` `  ` `  `     `  ``` dMMM##NNKrrrvzuuuuZZZZ
NN####HHHHHH@P<(?!`   <(=?<__`````` ```` ````  ` ``` ```` (HMMMNNN#OlttrrzzuuZZZ
N###HMH@@H@@Hb<Jk-  ` +zO1<___- `````````````````````````.(WWMNNNM6llltttrrvzuuu
##HHHH@@@@@@@D0$<_  ` jvOz?>;~~_.   ``````````````````` ._(WHM#NN#===lllttttrrzu
##HHH@@@@@ggHky_-.` `.wuwl?<:~_......```````````````. ._~__dMMMNN@=<<1llllttttrr
HHH@@@@gggmqqY?c(!   (zOrO?><_..````...``````````` ..~~_._~(HMMNM0!.J,1llllltttt
H@@@@gggmmqkW+k><  ``_ (wwz+<<___--__~_--__----((J++--._..~~dMM#CuvTB><llllttttt
@@@ggmmqkkbpWIXz_    .QHMMMMHHma&<_~:~~(jggMH@MHHHMBWWZ<__~~jMM@v1<~<_+llltttttt
@gmqkkbbppfWZXzZ<. ..JTXXA&+++zZUWO+<(+wWM6aQQQQHkQgzOZz<__~jMM4MNk~>(==lltttttt
mqqkbppfVyZZuuI1+- (XmuMMMMMM#7WWXI<~``jHKWU<HNN@?YTTI<~_._::1>(WMD(<?===llttttr
qkbbpfVyZZuuzvr<w_ _dWH$(OzTY<<1<<Zz_``(TI_(<_<<_-__._` `._::+z(7><!<??==llltrrr
bbppfVyZZuuvrrt>j:  ?wOO+=z<<<<<+ztv_  `.___~~___```   ``._(<zI_._`.>??===llttrr
ppfVVyZuuzvrttl>.~` .<rlOz<___:<+zt>_  ````   `````` ` ` __;+OO__` (>>?==lltttrr
pfVyZZuuzrttll=>`  `_(vOz<:_(::+ltI< ``...```  ```````.._(<+zrZXo+<;>??=lllttrrr
fVyZZuzvrttll=??<<` ;<zZOz<::::<zC ~``  ~.(-.  ` ```..~_(+zwzu>~::;;>?==lltrrrrv
VyyZuzvrttll==?>;< `(z_<=1<:~:(+v __``` .  js+- ``...._<>1wuuX<~::;>>?=ltttrvvzz
VyyZuzvrttll=??<<~   __ +?<:(+zI1Jz----(jgsdBOz<__.___(;+zruX$_::;;>?=lltrrzzzuu
VyZuuzrrttllz<!    `` ~ +?;;+z>:(+OXWQHMB=_  ?OOz<_~~(;<1zwX0<:::;>?==ltrrzuuuZZ
yZuuzvvrtv?! .(:.Jx ` . +=>?=<(++===1v1<~._..__?wOz<::<+ztwXs--:;>??=ltrvzuZZZyy
yuuzzvZ>` .(ggP.d@H-`  .+=??zzlllz<<<~~!_` _~<++jOz=>;>zOwXVyWWykAzzttrzuuZZyVVf
ZuXZ>` .jHMNNMljMMMH-  _+l<<1dUUXQme+-.(&ggmmkMHkO<>>?=zwXffyWVpppkHkXuuuZyyVfpp
7!  ..dMNNNNNMkMMgqHkl (1zz;+=;<lOOZvTTT7<<<;__?XIz+1zwwXkwVfWWWpkWqHWfVyXyVfpbk
 .(+d#NNNNNNNMHHH@Hmqko.zwwzz=++=lOwwA&&ee&zz++<vXwwwwXf(HXWWHHHHWmHHqHpWfWUUWWH
.dMNNNNNNNNNNMMMH@HHWHWkAwWkXOzzz+11++777<?<<<<<>zwWWHD`(HkWHWWHWHHmmqHHpW0vvvvZ
gMNNNNNNNNMM#MMHHHHkkHHHWpWHHkkwwz++<_ `  `   _(+dHMM3  dNKXWkHkkkHmH@gHWXXzvtOz
NNNNNNMMMMM#MMMMHH@HHHmHWHHM#TMNXXwOz++++--(((+dW@M9'  .NNNWfWWbmHWWHgqHXuzzrzwr
NNNNNNMMHHHM@H@HHMHMgHgHgHHHMm ?4HHkkQQkkQQQQkHMM9^`  .MNNNWHHWHqbpWUWMkZXwXXOOz
NNNN##M####MHHHMHgHHgmgHHHHHMMp  `?7WM##NN##NNMY!`   `(#NNMHHmgHWyZXXZWHkzXbkwOz
##NNNNMM#NM@@@MgHH@gmqHMMgMHM#Mp`     ?MNNNNMMN,     `(NNMMfHHHpWUZXWXWHZZXWkuuw
```

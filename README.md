# neumann package
[![apm](https://img.shields.io/apm/v/neumann.svg)](https://atom.io/packages/neumann)
[![downloads](https://img.shields.io/apm/dm/neumann.svg)](https://atom.io/packages/neumann)
[![license](https://img.shields.io/apm/l/neumann.svg)](https://atom.io/packages/neumann)
English [日本語](README.ja.md)

neumann is a package for [Atom](https://atom.io/) which predicts buggy codes using its Git change history.

## Usage
### Visualize buggy codes
command: `neumann:suspicious-lines`

The more red the codes get, the more buggy the codes are.

![Suspicious lines](https://github.com/MaxfieldWalker/neumann/wiki/gif/suspicious-lines.gif)

### Show bar chart of suspiciousness
command: `neumann:suspiciousness-graph`

![Suspiciousness graph](https://github.com/MaxfieldWalker/neumann/wiki/gif/suspiciousness-graph.gif)

## How it works
### Neumann Algorithm
neumann uses algorithm called **Neumann Algorithm** to predict buggy codes.
**Neumann Algorithm** evaluates codes by following some awesome rules.
<dl>
    <dt>Midnight rule</dt>
        <dd>Codes written at night are suspicious.</dd>
    <dt>Unreliable members rule</dt>
        <dd>Codes written by unreliable members are suspicious.</dd>
    <dt>Edit history rule</dt>
        <dd>Recently editted codes are more suspicious.</dd>
    <dt>Not committed rule</dt>
        <dd>Notify if the code is not yet commited.</dd>
</dl>


## Requirement
### Supported platforms
- Windows
- Mac
- Linux

## Installation
```
$ apm install neumann
```

or

1. Open Settings in [Atom](https://atom.io/) (Windows: `Ctrl`+`,` Mac: `⌘`+`,`)
- Go to Install
- Search for `neumann`
- Install

## Contribution
1. Fork it
- Create your feature branch (`git checkout -b new-feature`)
- Make your changes
- Commit your changes (`git commit -am 'Add some awesome feature'`)
- Push to the branch (`git push origin new-feature`)
- Create a new Pull Request

## Licence
[MIT](LICENSE.md)

## His name is Neumann
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

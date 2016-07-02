# CoffeeScriptについて

まず，CoffeeScriptはプログラミング言語の1つですが，コードはJavaScriptに変換されます．

なぜCoffeeScriptというものが存在するかというと，生のJavaScriptはなかなかの曲者(くせもの)で，クラスや継承とかいった話が異様に難しいのです．

CoffeeScriptではクラスの定義なんかも簡単に書けます．というかJavaScriptが難しすぎる．
AtomもCoffeeScriptで開発されていて，AtomのパッケージもCoffeeScriptで作ります．

ちなみにCoffeeScriptに似たようなものでマイクロソフトのTypeScriptがあります．
TypeScriptも最終的にはJavaScriptに変換されますが，主な機能として型付けができます．


# CoffeeScriptのインストール方法
1. CoffeeScriptはnpmというJava Scriptの様々なパッケージを管理するコマンドからインストールします。なのでまずはnpmを入れる必要があります。npmのインストール方法についてはOSによって様々なので調べてみてください。
ちなみに、HomeBrewが入っているManなら
	```
	$ brew install npm
	```
とするだけで入ります。

2. npmがインストールされていることを確認するために、次のコマンドを打ってnpmのバージョンが出ることを確認してみてください。(バージョン名が前後しているのは構いません)

	```
	$ npm --version
	3.9.5
	```

3. npmでCoffeeScriptをインストールします。
	
	```
	$ npm install -g coffee-script
	```


# CoffeeScriptでHello World
1. helloworld.coffeeに以下のソースコードを書きます．

    ```coffeescript
    console.log("Hello, World!")
    ```

1. ターミナルでコマンドを打って実行します．「coffee」コマンドはnpmからインストールします．npmについては各自で調べてください(´；ω；｀)

    ```
    $ coffee helloworld.coffee
    ```

1. "Hello, World!"と表示されれば成功です．

    ```
    $ coffee helloworld.coffee
    Hello, World!
    ```

# もうちょっとCoffeeScript
さっきのHello Worldの例は実はJavaScriptと全く同じなので，クラスの定義を含めたCoffeeScriptらしいことをやってみましょう．

1. person.coffeeに以下のソースコードを書きます.

    ```coffeescript
    class Person
      constructor: (name, age) ->
        @name = name
        @age = age

      greet: () ->
        console.log("Hello. I'm #{@name}.")

    naoto = new Person("Naoto", 20)

    naoto.greet()
    ```

1. 実行します．以下のように表示されれば成功です．

    ```
    $ coffee person.coffee
    Hello. I'm Naoto.
    ```

# [余談]JavaScriptについて
最近のJavaScriptの勢いは凄いです．いつのまにかJavaScriptでなんでもできちゃう時代になりました(Node.jsとか)．Web周りの技術の変化はとてつもないです．jQueryすらもう古いです．そのうちHTML+CSS+JavaScriptが全てを飲み込んでしまったりして...

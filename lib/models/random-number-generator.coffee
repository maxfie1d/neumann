module.exports = RandomNumberGenerator =
  # 1～10の数をランダムに生成します
  generate: ->
    Math.floor(Math.random() * 10) + 1;

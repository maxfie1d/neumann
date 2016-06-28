module.exports =
  # ルールの基底クラスです
  # 必ずevaluateメソッドをオーバーライドしてください
  #
  # ルール例:
  # やばい人ルール
  # 夜に書かれたコードはやばいルール
  class RuleBase
    constructor: ->
      @priority = 1

    evaluate: (codeLine) ->
      throw new Error("NotImplementedException")

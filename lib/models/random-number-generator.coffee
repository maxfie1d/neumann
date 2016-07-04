module.exports = RandomNumberGenerator =
	# 1～100の数をランダムに生成します
	generate: ->
		Math.floor(Math.random() * 100) + 1;

module.exports =
	# 評価の理由をもつクラスです

	# @level: 警告レベル (例: warning, errorなど)
	# @reason: 評価の理由
	class EvaluationReason
		constructor: (@level, @reason) ->

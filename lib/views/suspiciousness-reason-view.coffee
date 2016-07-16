{View} = require 'atom-space-pen-views'
{CompositeDisposable} = require 'atom'
{$$$} = require 'atom-space-pen-views'
Levels = require '../algorithm/levels'

module.exports =
	class SuspiciousnessReasonView extends View
		@content: ->
			@div class: 'suspiciousness-reason', =>
				@div class: 'container', =>
					@ul class: 'reason-list', outlet: 'reasonList', =>

		constructor: ->
			super # 必須

		update: (reasons)->
			# 下側にパネルを追加
			@panel ?= atom.workspace.addBottomPanel(item: this)

			# 前のアイテムを削除
			@reasonList.empty()

			for reason in reasons
				@renderReason(reason)

		renderReason: (reason) ->
			# Object.keysでオブジェクトのもつプロパティ名の配列を取得しています
			displayName = Object.keys(Levels)[reason.level]

			# 理由のli要素を作成
			reasonItem = $$$ ->
				@li =>
					@div class: 'flexbox', =>
						@span displayName, class: "level #{displayName}"
						@span reason.reason, class: 'reason'

			@reasonList.append(reasonItem)

		hide: ->
			@panel?.hide()

		show: ->
			@panel?.show()

		destroy: ->
			@panel.destroy()

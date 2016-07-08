{View} = require 'atom-space-pen-views'
{CompositeDisposable} = require 'atom'
{$$$} = require 'atom-space-pen-views'
Levels = require '../algorithm/levels'

module.exports =
	class SuspiciousReasonView extends View
		@content: ->
			@div class: 'suspicious-reason', =>
				@div class: 'container', =>
					@ul class: 'reason-list', outlet: 'reasonList', =>

		constructor: ->
			super

		update: (reasons)->
			@panel ?= atom.workspace.addBottomPanel(item: this)

			# 前のアイテムを削除
			@reasonList.empty()

			for reason in reasons
				@renderReason(reason)

		renderReason: (reason) ->
			displayName = Object.keys(Levels)[reason.level]
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

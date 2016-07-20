{ScrollView} = require "atom-space-pen-views"
git = require '../git'
CodeLine = require '../models/code-line'
$ = require 'jquery'

module.exports =
	class OptionEdtiorView extends ScrollView
		@content: ->
			@div class: 'option-editor', =>
				@div outlet: 'container', =>
					@h1 'Option Editor'

					# 危険な時間指定
					@form id: 'SetTime', =>
						@label "Time:"
						@input type: "time", step: "3600", id: 'startTime'
						@text("~")
						@input type: "time", step: "3600", id: 'endTime'

					@h3 'priority'

					@table =>
							@form id: 'time', =>
								@tr =>
									@td =>
										@label "Time:"
								@tr =>
								@td =>
									@input type: "range", min: "0", max: "100", id: 'timePriority'
							@form id: 'member', =>
								@tr =>
									@td =>
										@label "Member:"
								@tr =>
									@td =>
										@input type: "range", min: "0", max: "100", id: 'memberPriority', outlet: "memberPriority"
							@form id: 'nummod', =>
								@tr =>
									@td =>
										@label "NumMod:"
								@tr =>
									@td =>
										@input type: "range", min: "0", max: "100", id: 'NummodPriority'

					@form =>
						@input outlet: 'appButton', type: "button", value: "Application", id: 'appButton'

		initialize: ->
			# イベントの購読はここに書きます
			@appButton.on 'click', => @hoge()
			@memberPriority.on 'input', => @hoge()

		hoge: ->
			console.log @memberPriority.val()

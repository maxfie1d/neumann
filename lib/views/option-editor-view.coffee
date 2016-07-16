{ScrollView} = require "atom-space-pen-views"
git = require '../git'
CodeLine = require '../models/code-line'

module.exports =
	class OptionEdtiorView extends ScrollView
		@content: ->
			@div class: 'option-editor', =>
				@h1 'Option Editor'

				# 危険な時間指定
				@form =>
					@label "Time:"
					@input type: "time", step: "3600"
					@text("~")
					@input type: "time", step: "3600"

			#それぞれの人の危険度指定
#		 for i in x.author
				git.blame()
				.then (output) ->
					array = output.split('\n')[...-1]
					codeLines = []
					for item in array
						codeLine = new CodeLine(item)
						codeLines.push(codeLine)

						x.ahthor for x in codeLines
						@form =>
							@label x.author
							@input type: "range", min: "0", max: "100"

				@h3 'priority'

				@table =>
						@form =>
							@tr =>
								@td =>
									@label "Time:"
							@tr =>
							@td =>
								@input type: "range", min: "0", max: "100"
						@form =>
							@tr =>
								@td =>
									@label "Member:"
							@tr =>
								@td =>
									@input type: "range", min: "0", max: "100"
						@form =>
							@tr =>
								@td =>
									@label "NumMod:"
							@tr =>
								@td =>
									@input type: "range", min: "0", max: "100"

				@form =>
					@input type: "button", value: "Application"

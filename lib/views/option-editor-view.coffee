{ScrollView} = require "atom-space-pen-views"

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

					@input class: "btn", type: "button", value: "Application"

# #		x.ahthor for x in codeLines
#
#			#それぞれの人の危険度指定
# #		 for i in x.author
#				@form action: "xxx.php", method: "post", =>
#					@label "Name1", =>
#						@input type: "range", min: "0", max: "100",
#
#			@h3 'priority',
#
#			@form action: "xxx.php", method: "post", =>
#				@label "Time:", =>
#					@input type: "range", min: "0", max: "100",
#
#			@form action: "xxx.php", method: "post", =>
#				@label "Member:", =>
#					@input type: "range", min: "0", max: "100",
#
#			@form action: "xxx.php", method: "post", =>
#				@label "NumMod:", =>
#					@input type: "range", min: "0", max: "100",
#
#		 @input type: "button", value: "Application", OnClick: "",###

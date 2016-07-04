git = require '../git'
GitBlameView = require '../views/git-blame-view'
CodeLine = require './code-line'

module.exports = ->
	git.blame()
	.then (output) ->
		array = output.split('\n')[...-1]
		codeLines = []
		for item in array
			codeLine = new CodeLine(item)
			codeLines.push(codeLine)
			
		new GitBlameView(codeLines)
	.catch (e) ->
		console.log e

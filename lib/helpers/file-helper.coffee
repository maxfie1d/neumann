git = require '../git'
CodeLine = require '../models/code-line'
App = require '../app'

module.exports = FileHelper =
	getCodeLines: (path)->
		new Promise (resolve, reject) ->
			git.blame(path)
			.then (output) =>
				array = output.split('\n')[...-1]
				codeLines = []
				for item in array
					codeLine = new CodeLine(item)
					codeLines.push(codeLine)

				resolve(codeLines)
			.catch (e) ->
				console.log e
				reject(e)

	getEvaluatedCodeLines: (path)->
		new Promise (resolve, reject) ->
			FileHelper.getCodeLines(path)
			.then (codeLines) ->
				# アルゴリズムにコードを渡して疑わしさを評価してもらう
				codeLines = App.instance().algorithm.evaluate(codeLines)

				resolve(codeLines)
			.catch (e) ->
				reject(e)

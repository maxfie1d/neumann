git = require '../git'
CodeLine = require '../models/code-line'
App = require '../app'

module.exports = FileHelper =
	# CodeLineの配列を作って返します
	getCodeLines: (path)->
		new Promise (resolve, reject) ->
			git.blame(path)
			.then (output) =>
				# 改行で区切って，最後の空行は削除する
				array = output.split('\n')[...-1]

				codeLines = []
				for item in array
					line = new CodeLine(item)
					codeLines.push(line)

				resolve(codeLines)
			.catch (e) ->
				console.log e
				reject(e)

	# 危険度評価済みのCodeLineの配列を作って返します
	getEvaluatedCodeLines: (path)->
		new Promise (resolve, reject) ->
			# CodeLineの配列を作る
			FileHelper.getCodeLines(path)
			.then (codeLines) ->
				# アルゴリズムにコードを渡して疑わしさを評価してもらう
				codeLines = App.instance().algorithm.evaluate(codeLines)

				resolve(codeLines)
			.catch (e) ->
				reject(e)

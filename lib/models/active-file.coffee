git = require '../git'
CodeLine = require './code-line'
RandomAlgorithm = require '../algorithm/random-algorithm'
NeumannAlgorithm = require '../algorithm/neumann-algorithm'

module.exports = ActiveFile =
	getCodeLines: ->
		new Promise (resolve, reject) ->
			git.blame()
			.then (output) =>
				array = output.split('\n')[...-1]
				codeLines = []
				for item in array
					codeLine = new CodeLine(item)
					codeLines.push(codeLine)

				resolve(codeLines)
			.catch (e) ->
				console.log e

	getEvaluatedCodeLines: ->
		new Promise (resolve, reject) ->
			ActiveFile.getCodeLines()
			.then (codeLines) ->
				# アルゴリズムにコードを渡して疑わしさを評価してもらう
				algorithm = atom.config.get('neumann.algorithm')
				switch algorithm
					when "Neumann Algorithm"
						codeLines = NeumannAlgorithm.evaluate(codeLines)
					when "Random Algorithm"
						codeLines = RandomAlgorithm.evaluate(codeLines)

				resolve(codeLines)

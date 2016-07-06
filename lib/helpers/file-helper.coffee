git = require '../git'
CodeLine = require '../models/code-line'
RandomAlgorithm = require '../algorithm/random-algorithm'
NeumannAlgorithm = require '../algorithm/neumann-algorithm'

module.exports = FileHelper =
	algorithm: null

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

	getEvaluatedCodeLines: (path)->
		new Promise (resolve, reject) ->
			FileHelper.getCodeLines(path)
			.then (codeLines) ->
				# アルゴリズムにコードを渡して疑わしさを評価してもらう
				algorithm = atom.config.get('neumann.algorithm')
				switch algorithm
					when "Neumann Algorithm"
						algorithm = new NeumannAlgorithm() unless @algorithm instanceof NeumannAlgorithm
					when "Random Algorithm"
						algorithm = new RandomAlgorithm() unless @algorithm instanceof RandomAlgorithm

				codeLines = algorithm.evaluate(codeLines)

				resolve(codeLines)

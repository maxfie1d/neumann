AlgorithmBase = require './algorithm-base'
MidnightRule = require './midnight-rule'

module.exports =
  class NeumannAlgorithm extends AlgorithmBase
    rules = [
      new MidnightRule(16, 3, 10) # 16時～3時に書かれたコードは危険とする
    ]

    @evaluate: (codeLines) =>
      for codeLine in codeLines
        for rule in rules
          codeLine.suspicious += rule.evaluate(codeLine)

      return codeLines

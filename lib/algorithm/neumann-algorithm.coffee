AlgorithmBase = require './algorithm-base'
MidnightRule = require './midnight-rule'
UnreliableMembersRule = require './unreliable-members-rule'

module.exports =
  class NeumannAlgorithm extends AlgorithmBase
    rules = [
      new MidnightRule(16, 3, 10), # 16時～3時に書かれたコードは危険とする
      new UnreliableMembersRule(10),
    ]

    @evaluate: (codeLines) =>
      for codeLine in codeLines
        for rule in rules
          codeLine.suspicious += rule.evaluate(codeLine)

      return codeLines
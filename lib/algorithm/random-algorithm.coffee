AlgorithmBase = require './algorithm-base'
RandomNumberGenerator = require '../models/random-number-generator'

module.exports =
  # 疑わしさをランダムで与えるアルゴリズムです
  class RandomAlgorithm extends AlgorithmBase
    @evaluate: (codeLines) ->
      for codeLine in codeLines
        codeLine.suspicious = RandomNumberGenerator.generate()

      return codeLines

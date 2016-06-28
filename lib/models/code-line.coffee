module.exports =
  class CodeLine
    constructor: (line) ->
      # git blame format
      # d3d87346 (tarohi24     2016-06-11 19:11:24 +0900  8) # 開発ルール
      collection = line.match(/([0-9a-f\^]{8}).+?\((.+?)\s+([0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2} [+-][0-9]{4})\s+([0-9]+)\) (.*)/)

      @commitId = collection[1]
      @author = collection[2]
      @timestamp = new Date(collection[3])
      @line = collection[4]
      @code = collection[5]

      @raw  = line

      # 疑わしさの度合い
      @suspicious = 0

    toString: =>
      @raw

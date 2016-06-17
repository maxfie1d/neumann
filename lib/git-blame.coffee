git = require './git'
GitBlameView = require './git-blame-view'

module.exports = ->
  git.blame()
  .then (output) ->
    new GitBlameView(output)
  .catch (e) ->
    console.log e

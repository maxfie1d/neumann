git = require '../git'
GitBlameView = require '../views/git-blame-view'

module.exports = ->
  git.blame()
  .then (output) ->
    new GitBlameView(output)
  .catch (e) ->
    console.log e

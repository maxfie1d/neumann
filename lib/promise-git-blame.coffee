git = require './git'
PromiseGitBlameView = require './promise-git-blame-view'

module.exports = ->
  git.blame()
  .then (output) ->
    new PromiseGitBlameView(output)
  .catch (e) ->
    console.log e

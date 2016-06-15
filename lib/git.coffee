{BufferedProcess} = require 'atom'
{Directory} = require 'atom'

getRepository = ->
  new Promise (resolve, reject) ->
    getRepositoryForActiveFile()
    .then (repository) ->
      resolve(repository)
    .catch (e) ->
      reject(e)

getRepositoryForActiveFile = ->
  new Promise (resolve, reject) ->
    project = atom.project
    activeFilePath = atom.workspace.getActiveTextEditor()?.getPath()
    # Atomで開いているディレクトリのうち，現在開いているファイルを含むものを選ぶ
    directory = project.getDirectories().filter((d) -> d.contains(activeFilePath))[0]
    if directory?
      project.repositoryForDirectory(directory)
      .then (repository) ->
        resolve(repository)
      .catch (e) ->
        reject(e)
    else
      reject "There are no project folder that contains the active file."

module.exports = git =
  execute: (args, options={ env: process.env }) ->
    new Promise (resolve, reject) ->
      output = ''
      try
        new BufferedProcess
          command: 'git'
          args: args
          options: options
          stdout: (data) -> output += data.toString()
          stderr: (data) -> output += data.toString()
          exit: (code) ->
            if code is 0
              resolve output
            else
              reject output
      catch
        reject 'Could not find git'

  blame: ->
    getRepository()
    .then (repo) ->
      # GitRepository.relativize()を使うとrealpathが返されるようなので
      # Direcotry.relativize()を使っています
      workingDir = new Directory(repo.getWorkingDirectory())
      file = workingDir.relativize(atom.workspace.getActiveTextEditor()?.getPath())
      git.execute(['blame', file], cwd: repo.getWorkingDirectory())
      .then (output) ->
        console.log output

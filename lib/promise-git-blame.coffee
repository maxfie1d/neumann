{BufferedProcess} = require 'atom'

module.exports = (args, options={ env: process.env }) ->
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
  .then (output) ->
    console.log output

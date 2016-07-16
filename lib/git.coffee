{BufferedProcess} = require 'atom'
{Directory} = require 'atom'

getRepository = (path) ->
	new Promise (resolve, reject) ->
		getRepositoryForFile(path)
		.then (repository) ->
			resolve(repository)
		.catch (e) ->
			atom.notifications.addError(e)
			reject(e)

# pathに対するリポジトリを返します
getRepositoryForFile = (path) ->
	new Promise (resolve, reject) ->
		project = atom.project
		# Atomで開いているディレクトリのうち，現在開いているファイルを含むものを選ぶ
		directory = project.getDirectories().filter((d) -> d.contains(path))[0]
		if directory?
			project.repositoryForDirectory(directory)
			.then (repository) ->
				unless repository is null
					resolve(repository)
				else
					reject('Not a git repository.')
			.catch (e) ->
				reject(e)
		else
			reject "There are no project folder that contains the active file."

module.exports = git =
	execute: (args, options={ env: process.env }) ->
		new Promise (resolve, reject) ->
			output = ''
			try
				# 外部コマンド(git)を実行
				new BufferedProcess
					command: atom.config.get('neumann.gitPath') ? 'git' # コマンド
					args: args                                          # 引数
					options: options                                    # オプション
					stdout: (data) -> output += data.toString()         # 標準出力
					stderr: (data) -> output += data.toString()         # 標準エラー
					exit: (code) ->
						if code is 0
							resolve output
						else
							atom.notifications.addError(output)
							reject output
			catch
				atom.notifications.addError('git is not available, or not on the PATH')
				reject 'Could not find git'

	# git blame <file>
	blame: (path)->
		if not path?
			path = atom.workspace.getActiveTextEditor()?.getPath()

		getRepository(path)
		.then (repo) ->
			# GitRepository.relativize()を使うとrealpathが返されるようなので
			# Direcotry.relativize()を使っています
			workingDir = new Directory(repo.getWorkingDirectory())
			file = workingDir.relativize(path).replace(/\\/g, '/')
			git.execute(['blame', file], cwd: repo.getWorkingDirectory())

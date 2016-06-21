module.exports =
  class GitBlameView
    _panel = null

    constructor: (codeLines) ->
      if _panel?.isVisible()
        _panel.hide()
        _panel.destroy()
        return

      @element = document.createElement('div')
      @element.classList.add('git-blame-container')

      list = document.createElement('ul')
      for codeLine in codeLines
        listItem = document.createElement('li')

        listItem.appendChild(document.createTextNode(codeLine.commitId))
        listItem.appendChild(document.createTextNode(codeLine.author))

        timestamp = document.createElement('b')
        timestamp.textContent = codeLine.timestamp
        listItem.appendChild(timestamp)

        listItem.appendChild(document.createTextNode(codeLine.line))
        listItem.appendChild(document.createTextNode(codeLine.code))

        list.appendChild(listItem)

      #elementにlistを追加
      @element.appendChild(list)

      _panel = atom.workspace.addModalPanel(item: @element)
      _panel.show()

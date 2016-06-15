module.exports =
  class PromiseGitBlameView
    _panel = null

    constructor: (@output) ->
      if _panel?.isVisible()
        _panel.hide()
        _panel.destroy()
        return

      @element = document.createElement('div')
      @element.classList.add('git-blame-container')

      array = @output.split('\n')[...-1]

      list = document.createElement('ul')
      for item in array
        listItem = document.createElement('li')
        collection = item.match(/(.*)([0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2} [+-][0-9]{4})(.*)/)

        listItem.appendChild(document.createTextNode(collection[1]))

        timestamp = document.createElement('b')
        timestamp.textContent = collection[2]
        listItem.appendChild(timestamp)

        listItem.appendChild(document.createTextNode(collection[3]))

        list.appendChild(listItem)

      #elementにlistを追加
      @element.appendChild(list)

      _panel = atom.workspace.addModalPanel(item: @element)
      _panel.show()

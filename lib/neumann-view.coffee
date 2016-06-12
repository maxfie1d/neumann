module.exports =
class NeumannView
  constructor: (serializedState) ->
    # Create root element
    @element = document.createElement('div')
    @element.classList.add('neumann')

    # Create message element
    message = document.createElement('div')
    message.textContent = "The Neumann package is Alive! It's ALIVE!"
    message.classList.add('message')
    @element.appendChild(message)

  setText: (text) ->

    #改行で分割
    array = text.split('\n')
    #空行を削除
    array.pop()

    list= document.createElement('ul')
    for item in array
      listItem = document.createElement('li')
      collection = item.match(/(.*)([0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2} [+-][0-9]{4})(.*)/)
      listItem.appendChild(document.createTextNode(collection[1]))

      timestamp = document.createElement('b')
      timestamp.textContent = collection[2]
      listItem.appendChild(timestamp)

      listItem.appendChild(document.createTextNode(collection[3]))

      list.appendChild(listItem)

    #elementの中身を空に
    while @element.hasChildNodes()
      @element.removeChild(@element.lastChild)

    #elementにlistを追加
    @element.appendChild(list)

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  getElement: ->
    @element

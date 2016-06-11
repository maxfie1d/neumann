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
    displayText = "Project Dir: #{text}"
    @element.children[0].textContent=displayText;

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @element.remove()

  getElement: ->
    @element

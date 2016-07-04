class Person
		constructor: (name, age) ->
				@name = name
				@age = age

		greet: () ->
				console.log("Hello. I'm #{@name}.")

naoto = new Person("Naoto", 20)

naoto.greet()

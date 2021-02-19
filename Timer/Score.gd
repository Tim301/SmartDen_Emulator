extends Node
class_name Score

var array

func _init():
	array = []

func add(note: Note):
	array.append(note)

func fprint():
	print("length: " + str(array.size()))
	for i in range(array.size()):
		var tmp = array[i].printState()
		print(tmp)
		print("*")

extends Control
class_name Note

var _time_in: Time
var _time_out: Time
var _duration: Time
var _pitch: int
var _type:String # Note_On, Note_Off

func _init(time,pitch,type):
	_time_in = time
	_pitch = pitch
	_type = type

func close_note(time):
	_time_out
	var duration = Time.new()
	duration.set_
	


func printState():
	print("time: " + _time_in.format() + ", pitch: " + str(_pitch)+ ", type: " + str(_type))

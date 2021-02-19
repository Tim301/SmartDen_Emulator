extends Control

var is_recording = false
var startTime = 0
var elapsedTime: Time
var myScore = Score.new()

func _process(_delta):
	if is_recording:
		elapsedTime = Time.new(OS.get_ticks_msec()-startTime)
		get_node("Label").text = elapsedTime.format()
	else:
		pass

func _on_Rec_Button_Start_Record():
	is_recording = !is_recording
	startTime = OS.get_ticks_msec()

func _on_Note_button_down():
	var test = Note.new(elapsedTime,58,"Note_On")
	test.printState()
	myScore.add(test)

func _on_Note_button_up():
	var test = Note.new(elapsedTime,58,"Note_Off")
	test.printState()
	myScore.add(test)

func _on_Print_button_down():
	myScore.fprint()


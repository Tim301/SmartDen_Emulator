extends Control

var light_Ext = false
var light_Int = false
var DMX_Sender


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Light_Ext").enabled = light_Ext
	get_node("Light_Int").enabled = light_Int
	$HTTPRequest.connect("request_completed", self, "_on_request_completed")
	#var headers = ["User-Agent:Firefox/5.0"]
	#$HTTPRequest.request("http://127.0.0.1/current state.json?Relay2=1",headers,false,HTTPClient.METHOD_POST)

func _on_request_completed(result, response_code, headers, body):
	print(result)
	print(response_code)
	print(response_code)
	print(headers)
	#var json = JSON.parse(body.get_string_from_utf8())
	print(body.get_string_from_utf8())

func _on_Button_pressed():
	light_Ext = !light_Ext
	get_node("Light_Ext").enabled = light_Ext
	var error = $HTTPRequest.request("http://127.0.0.1/current state.json?Relay2=1")
	if error != OK:
		push_error("An error occurred in the HTTP request.")


func _on_Button2_pressed():
	light_Int = !light_Int
	get_node("Light_Int").enabled = light_Int

extends Control

var URL ="http://192.168.1.100/current_state.json"

var light_Ext = false
var light_Int = false


# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Light_Ext").enabled = light_Ext
	get_node("Light_Int").enabled = light_Int
	$HTTPRequest.connect("request_completed", self, "_on_request_completed")
	$HTTPRequest.timeout = 1

func _on_Button_Int_pressed():
	light_Int = !light_Int
	get_node("Light_Int").enabled = light_Int
	if light_Int == true:
		$HTTPRequest.request(URL + "?Relay16=1")
		print("light Int On **************************")
	else:
		$HTTPRequest.request(URL + "?Relay16=0")
		print("light Int Off -------------------------")

func _on_Button_Ext_pressed():
	light_Ext = !light_Ext
	get_node("Light_Ext").enabled = light_Ext
	if light_Ext:
		$HTTPRequest.request(URL + "?Relay15=1")
		print("light Ext On")
	else:
		$HTTPRequest.request(URL + "?Relay15=0")
		print("light Ext Off")

func _on_Timer_timeout():
	var error = $HTTPRequest.request(URL + "?pw=admin")
	if error != OK:
		push_error("An error occurred in the HTTP request.")

func _on_request_completed(result, response_code, headers, body):
	var json = JSON.parse(body.get_string_from_utf8())
	if len(body.get_string_from_utf8()) != 0:
		#print(json.result)
		print("JSON Ext:" + json.result["CurrentState"]["Output"][14]["Value"])
		print("JSON Int:" + json.result["CurrentState"]["Output"][15]["Value"])
		light_Ext = bool(int(json.result["CurrentState"]["Output"][14]["Value"]))
		light_Int = bool(int(json.result["CurrentState"]["Output"][15]["Value"]))
		get_node("Light_Ext").enabled = light_Ext
		get_node("Light_Int").enabled = light_Int
		print("Light Ext:" + str(light_Ext))
		print("Light Int:" + str(light_Int))


func _on_Button_M3_On_pressed():
	$HTTPRequest.request(URL + "?Relay1=1")
	print("Motor 3 On")

func _on_Button_M3_Off_pressed():
	$HTTPRequest.request(URL + "?Relay2=1")
	print("Motor 3 Off")

func _on_Button_M4_On_pressed():
	$HTTPRequest.request(URL + "?Relay3=1")
	print("Motor 4 On")

func _on_Button_M4_Off_pressed():
	$HTTPRequest.request(URL + "?Relay4=1")
	print("Motor 4 Off")

func _on_Button_M5_On_pressed():
	$HTTPRequest.request(URL + "?Relay5=1")
	print("Motor 5 On")

func _on_Button_M5_Off_pressed():
	$HTTPRequest.request(URL + "?Relay6=1")
	print("Motor 5 Off")

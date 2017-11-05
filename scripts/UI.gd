extends CanvasLayer

onready var label_message = get_node("message")
onready var message_timer = get_node("message_timer")

func _ready():
	pass

func _input(event):
	if(event.is_action_pressed("game_pause")):
		globals.paused = not globals.paused
		get_tree().set_pause(globals.paused)
		if(globals.paused):
			get_node("pause_popup").show()
			label_message.hide()
		else:
			get_node("pause_popup").hide()
			label_message.show()
		
func update():
	pass
	
func show_message(text):
	label_message.set_text(str(text))
	message_timer.start()

func _on_message_timer_timeout():
	label_message.hide()
	label_message.set_text("")

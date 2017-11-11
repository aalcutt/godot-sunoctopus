extends Control

func _ready():
	set_process(true)
	
func _process(delta):
	if(Input.is_action_pressed("menu_close")):
		get_node("credits").hide()

func _on_start_button_pressed():
	globals.new_game()

func _on_credits_button_pressed():
	get_node("credits").show();
	

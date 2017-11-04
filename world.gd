extends Node2D

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	if(Input.is_action_pressed("player_right")):
		rotation += (1 * delta);
	if(Input.is_action_pressed("player_left")):
		rotation -= (1 * delta);
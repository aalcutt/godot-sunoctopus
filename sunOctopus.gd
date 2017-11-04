extends KinematicBody2D

var HEALTH = 5;

func _ready():
	add_to_group("boss")
	set_fixed_process(true)
	
func _fixed_process(delta):
	pass

func damage(dmg):
	HEALTH -= dmg
	if(HEALTH <= 0):
		destroy()
		
func destroy():
	queue_free()


func _on_sunOctopus_body_entered( body ):
	print(body.get_name())
	

extends Area2D

# Member variables
var vel = Vector2()
const SPEED = 800

func _ready():
	set_process(true)

func start_at(dir, pos, v):
	position = pos
	vel = Vector2(SPEED, 0).rotated(dir)

func _process(delta):
	position = position + vel * delta
	
func _on_lifetime_timeout():
	queue_free()
	
func _on_visible_exit_screen():
	queue_free()
	
func _on_shot_body_entered( body ):
	if(body.get_name() != "player"):
		if(body.has_method("damage")):
			body.damage(1)
		queue_free()

func _on_shot_area_entered( area ):
	if(area.get_name() != "player"):
		if(area.has_method("damage")):
			area.damage(1)
		queue_free()

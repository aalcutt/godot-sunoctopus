extends Area2D

# Member variables
var vel = Vector2()
const SPEED = 800

func _ready():
	set_fixed_process(true)

func start_at(dir, pos, v):
	rotation = dir
	position = pos
	vel = Vector2(SPEED, 0).rotated(dir)

func _fixed_process(delta):
	position = position + vel * delta
	
func _on_lifetime_timeout():
	queue_free()
	
func _on_visible_exit_screen():
	queue_free()
	
func _on_shot_body_entered( body ):
	#print(body.get_name())
	if(body.has_method("damage")):
		body.damage(1)

func _on_shot_area_entered( area ):
	#print(area.get_name())
	if(area.has_method("damage")):
		area.damage(1)

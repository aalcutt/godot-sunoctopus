extends KinematicBody2D

var shotscene = preload("res://shot.tscn")

const GRAVITY = 200.0
const JUMP_SPEED = 100.0
var velocity = Vector2()

func _ready():
	set_fixed_process(true)
	
func _fixed_process(delta):
	velocity.y += delta * GRAVITY
	
	if(Input.is_action_pressed("player_jump")):
		velocity.y=-JUMP_SPEED
	
	var motion = velocity * delta
	move(motion)
	
	if(Input.is_action_pressed("player_shoot")):
		shoot()
		

func shoot():
	var shot = shotscene.instance()
	var shotLocation = get_node("shootfrom").global_position
	var angleToMouse = get_angle_to(get_global_mouse_position())
	shot.start_at(angleToMouse, shotLocation, shot.SPEED)
	get_node("../").add_child(shot)


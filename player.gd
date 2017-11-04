extends KinematicBody2D

onready var shot_timer = get_node("shotTimer")
onready var label_player_health = get_parent().get_node("UI").get_node("label_player_health")

var shotscene = preload("res://shot.tscn")

const GRAVITY = 200.0
const JUMP_SPEED = 100.0
var velocity = Vector2()
var player_health = 3

func _ready():
	add_to_group("player")
	label_player_health.set_text("health: " + str(player_health))
	set_fixed_process(true)
	
func _fixed_process(delta):
	velocity.y += delta * GRAVITY
	
	if(Input.is_action_pressed("player_jump")):
		velocity.y=-JUMP_SPEED
	
	var motion = velocity * delta
	move(motion)
	
	if(Input.is_action_pressed("player_shoot")):
		if(shot_timer.get_time_left() == 0):
			shoot()
		

func shoot():
	shot_timer.start();
	var shot = shotscene.instance()
	var shotLocation = get_node("shootfrom").global_position
	var angleToMouse = get_angle_to(get_global_mouse_position())
	shot.start_at(angleToMouse, shotLocation, shot.SPEED)
	get_node("../").add_child(shot)
	
func damage(dmg):
	player_health -= dmg
	label_player_health.set_text("health: " + str(player_health))
	if(player_health <= 0):
		destroy()
		
func destroy():
	queue_free()


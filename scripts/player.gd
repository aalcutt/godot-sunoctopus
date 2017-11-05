extends KinematicBody2D

signal player_dead

onready var shot_timer = get_node("shotTimer")
onready var label_player_health = get_parent().get_node("UI").get_node("label_player_health")

var shotscene = preload("res://scenes/shot.tscn")

const GRAVITY = 200.0
const JUMP_SPEED = 100.0
var velocity = Vector2()

func _ready():
	add_to_group("player")
	label_player_health.set_text("health: " + str(globals.player_health))
	set_physics_process(true)
	
func _physics_process(delta):
	velocity.y += delta * GRAVITY
	
	if(Input.is_action_pressed("player_jump")):
		velocity.y=-JUMP_SPEED
		
	if(Input.is_action_pressed("player_left")):
		get_node("sprite").set_flip_h(true)
		
	if(Input.is_action_pressed("player_right")):
		get_node("sprite").set_flip_h(false)
	
	var motion = velocity * delta
	move_and_collide(motion)
	move
	
	if(Input.is_action_pressed("player_shoot")):
		if(shot_timer.get_time_left() == 0):
			shoot()
	
	if(position.x > globals.worldwidth):
		destroy()
	if(position.x < 0):
		destroy()
	if(position.y > globals.worldheight):
		destroy()
	if(position.y < 0):
		destroy()

func shoot():
	shot_timer.start();
	var shot = shotscene.instance()
	var shotLocation = get_node("shootfrom").global_position
	var angleToMouse = get_angle_to(get_global_mouse_position())
	shot.start_at(angleToMouse, shotLocation, shot.SPEED)
	get_node("../").add_child(shot)
	
func damage(dmg):
	globals.player_health -= dmg
	label_player_health.set_text("health: " + str(globals.player_health))
	if(globals.player_health <= 0):
		destroy()
		
func destroy():
	emit_signal("player_dead")
	#disable()
	queue_free()
	
func disable():
	hide()
	set_fixed_process(false)
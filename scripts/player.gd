extends KinematicBody2D

signal player_dead

onready var shot_timer = get_node("shotTimer")
onready var alt_shot_timer = get_node("altShotTimer")
onready var label_player_health = get_parent().get_node("UI").get_node("label_player_health")
onready var ground_ray = get_node("ground_ray")
onready var sound_jump = get_node("sound_jump")
onready var sound_damaged = get_node("sound_damaged")
onready var sound_dead = get_node("sound_dead")


var shotscene = preload("res://scenes/shot.tscn")
var buildshotscene = preload("res://scenes/build_shot.tscn")

const GRAVITY = 200.0
const JUMP_SPEED = 150.0
var velocity = Vector2()

func _ready():
	add_to_group("player")
	label_player_health.set_text("health: " + str(globals.player_health))
	set_physics_process(true)
	
func _physics_process(delta):
	velocity.y += delta * GRAVITY
	
	if(Input.is_action_pressed("player_jump") and ground_ray.is_colliding()):
	#if(Input.is_action_pressed("player_jump")):
		velocity.y =- JUMP_SPEED
		sound_jump.play()
		
	if(Input.is_action_pressed("player_left")):
		get_node("sprite").set_flip_h(true)
		position.x -= 1
		
	if(Input.is_action_pressed("player_right")):
		get_node("sprite").set_flip_h(false)
		position.x += 1
	
	var motion = velocity * delta
	move_and_collide(motion)

	
	if(Input.is_action_pressed("player_shoot")):
		if(shot_timer.get_time_left() == 0):
			shoot()
	
	if(Input.is_action_pressed("player_alt_shoot")):
		if(alt_shot_timer.get_time_left() == 0):
			build_shoot()
	
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
	
func build_shoot():
	alt_shot_timer.start();
	var shot = buildshotscene.instance()
	var shotLocation = get_node("shootfrom").global_position
	var angleToMouse = get_angle_to(get_global_mouse_position())
	shot.start_at(angleToMouse, shotLocation, shot.SPEED)
	get_node("../").add_child(shot)
	
func damage(dmg):
	globals.player_health -= dmg
	label_player_health.set_text("health: " + str(globals.player_health))
	sound_damaged.play()
	if(globals.player_health <= 0):
		destroy()
		
func destroy():
	sound_dead.play()
	emit_signal("player_dead")
	#disable()
	#queue_free()
	
func disable():
	hide()
	set_fixed_process(false)
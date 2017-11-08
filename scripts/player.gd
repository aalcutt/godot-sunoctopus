extends KinematicBody2D

signal player_dead

onready var shot_timer = get_node("shotTimer")
onready var alt_shot_timer = get_node("altShotTimer")
onready var label_player_health = get_parent().get_node("UI").get_node("label_player_health")
onready var ground_ray = get_node("ground_ray")
onready var camera = get_node("camera")

var shotscene = preload("res://scenes/shot.tscn")
var buildshotscene = preload("res://scenes/build_shot.tscn")

const GRAVITY = 200.0
const JUMP_SPEED = 150.0
var velocity = Vector2()

func _ready():
	add_to_group("player")
	label_player_health.set_text("health: " + str(globals.player_health))
	set_physics_process(true)
	camera.limit_left = 0
	camera.limit_right = globals.worldwidth
	camera.limit_top = 0
	camera.limit_bottom = globals.worldheight
	camera.drag_margin_bottom = .25
	camera.drag_margin_top = .25
	
func _physics_process(delta):
	velocity.y += delta * GRAVITY
	
	#if(Input.is_action_pressed("player_jump") and ground_ray.is_colliding()):
	if(Input.is_action_pressed("player_jump")):
		velocity.y =- JUMP_SPEED
		
	if(Input.is_action_pressed("player_left")):
		get_node("sprite").set_flip_h(true)
		#position.x -= 1
		
	if(Input.is_action_pressed("player_right")):
		get_node("sprite").set_flip_h(false)
		#position.x += 1
	
	var motion = velocity * delta
	move_and_collide(motion)

	
	if(Input.is_action_pressed("player_shoot")):
		if(shot_timer.get_time_left() == 0):
			shoot()
	
	if(Input.is_action_pressed("player_alt_shoot")):
		if(alt_shot_timer.get_time_left() == 0):
			build_shoot()
	
	var maxDistance = 1200
	var minDistance = 600
	#if(position.y + 50 > 600):
	#	camera.limit_bottom = globals.worldheight
	#else:
	#	camera.current = false
	#	camera.global_position = Vector2(512,300)
	#	var zoom = position.y / (maxDistance - minDistance)
	#	camera.set_zoom(Vector2(zoom,zoom))
	
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
	if(globals.player_health <= 0):
		destroy()
		
func destroy():
	emit_signal("player_dead")
	#disable()
	queue_free()
	
func disable():
	hide()
	set_fixed_process(false)
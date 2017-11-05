extends Area2D

signal boss_dead

onready var label_health = get_parent().get_node("UI").get_node("BossHealth")
onready var boss_shot = preload("res://scenes/boss_shot.tscn")
onready var shoot_timer = get_node("shoot_timer")
onready var shot_container = get_node("shot_container")
onready var player_target = get_parent().get_node("player")
onready var UI = get_parent().get_node("UI")

var shot1_accuracy = .5;

func _ready():
	set_process(true)
	add_to_group("boss")
	label_health.set_text(str(globals.boss_health))
	shoot_timer.set_wait_time(1.5)
	shoot_timer.start()
	
func _process(delta):
	pass

func damage(dmg):
	globals.boss_health -= dmg
	label_health.set_text(str(globals.boss_health))
	if(globals.boss_health <= 0):
		destroy()
		
func destroy():
	emit_signal("boss_dead")
	queue_free()

func shoot1():
	var dir = get_global_position() - player_target.position
	var b = boss_shot.instance()
	shot_container.add_child(b)
	var r = rand_range(-shot1_accuracy, shot1_accuracy)
	b.start_at(get_angle_to(player_target.position) + r, get_global_position())

func _on_sunOctopus_body_entered( body ):
	print(body.get_name())
	
func _on_shoot_timer_timeout():
	shoot1()

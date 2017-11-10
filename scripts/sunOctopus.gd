extends Area2D

signal boss_dead

onready var label_health = get_parent().get_node("UI").get_node("BossHealth")
onready var boss_shot = preload("res://scenes/boss_shot.tscn")
onready var shoot_timer = get_node("shoot_timer")
onready var shoot2_timer = get_node("shoot2_timer")
onready var shot_container = get_node("shot_container")
onready var player_target = get_parent().get_node("player")
onready var UI = get_parent().get_node("UI")
onready var sound_damaged = get_node("sound_damaged")
onready var sound_shot2 = get_node("sound_shot2")

var shot1_accuracy = .2;
var shot2_accuracy = .1;

func _ready():
	set_process(true)
	add_to_group("boss")
	label_health.set_text(str(globals.boss_health))
	shoot_timer.set_wait_time(1.5)
	shoot_timer.start()
	shoot2_timer.set_wait_time(10)
	shoot2_timer.start()
	
func _process(delta):
	pass

func damage(dmg):
	globals.boss_health -= dmg
	label_health.set_text(str(globals.boss_health))
	sound_damaged.play()
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
	
func shoot2():
	var dir = get_global_position()
	var r = rand_range(-shot2_accuracy, shot2_accuracy)
	for a in [-2, -1, 0, 1, 2, 3]:
		var b = boss_shot.instance()
		shot_container.add_child(b)
		b.start_at(dir.angle() + a + r, get_global_position())
	sound_shot2.play()

func _on_sunOctopus_body_entered( body ):
	print(body.get_name())
	
func _on_shoot_timer_timeout():
	shoot1()

func _on_shoot2_timer_timeout():
	shoot2()

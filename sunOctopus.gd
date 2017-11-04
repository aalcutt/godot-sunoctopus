extends Area2D

onready var label_health = get_parent().get_node("UI").get_node("BossHealth")
onready var boss_shot = preload("res://boss_shot.tscn")
onready var shoot_timer = get_node("shoot_timer")
onready var shot_container = get_node("shot_container")
onready var player_target = get_parent().get_node("player")

var HEALTH = 10;

func _ready():
	set_fixed_process(true)
	add_to_group("boss")
	label_health.set_text(str(HEALTH))
	shoot_timer.set_wait_time(1.5)
	shoot_timer.start()
	
func _fixed_process(delta):
	pass

func damage(dmg):
	HEALTH -= dmg
	label_health.set_text(str(HEALTH))
	if(HEALTH <= 0):
		destroy()
		
func destroy():
	queue_free()

func shoot1():
	var dir = get_global_position() - player_target.position
	var b = boss_shot.instance()
	shot_container.add_child(b)
	b.start_at(get_angle_to(player_target.position), get_global_position())

func _on_sunOctopus_body_entered( body ):
	print(body.get_name())
	
func _on_shoot_timer_timeout():
	shoot1()

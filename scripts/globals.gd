extends Node

# game variables
var player_health = 100
var boss_health = 1
var game_over = false
var paused = false


const worldwidth = 1024
const worldheight = 600

var current_scene = null
var new_scene = null

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() -1 )

func goto_scene(path):
	var s = ResourceLoader.load(path)
	new_scene = s.instance()
	get_tree().get_root().add_child(new_scene)
	get_tree().set_current_scene(new_scene)
	current_scene.queue_free()
	current_scene = new_scene
	
func new_game():
	print("new game")
	game_over = false
	player_health = 10
	boss_health = 10
	goto_scene("res://scenes/game.tscn")
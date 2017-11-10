extends Node

const PLAYER_STARTING_HEALTH = 10
const BOSS_STARTING_HEALTH = 50

# game variables
var player_health = PLAYER_STARTING_HEALTH
var boss_health = BOSS_STARTING_HEALTH
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
	get_tree().set_pause(false)
	game_over = false
	player_health = PLAYER_STARTING_HEALTH
	boss_health = BOSS_STARTING_HEALTH
	goto_scene("res://scenes/game.tscn")
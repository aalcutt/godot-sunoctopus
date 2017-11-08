extends Node2D

onready var player = get_node("player")
onready var UI = get_node("UI")
onready var reset_timer = get_node("reset_timer")
onready var boss = get_node("sunOctopus")
onready var background_music = get_node("background_music")

func _ready():
	player.connect("player_dead", self, "game_over")
	boss.connect("boss_dead", self, "victory")
	UI.show_message("LEVEL 1")
	
func game_over():
	UI.show_message("GAME OVER")
	reset_timer.start()
	get_tree().set_pause(true)

func victory():
	print("victory")
	UI.show_message("VICTORY!")
	reset_timer.start()
	get_tree().set_pause(true)

func _on_reset_timer_timeout():
	globals.new_game()

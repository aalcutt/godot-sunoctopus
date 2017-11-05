extends Node2D

onready var player = get_node("player")
onready var UI = get_node("UI")
onready var reset_timer = get_node("reset_timer")
onready var boss = get_node("sunOctopus")

func _ready():
	#var screen_size = OS.get_screen_size()
	#var window_size = OS.get_window_size()
	#OS.set_window_position(screen_size*0.5 - window_size*0.5)
	player.connect("player_dead", self, "game_over")
	boss.connect("boss_dead", self, "victory")
	UI.show_message("LEVEL 1")
	
func game_over():
	UI.show_message("GAME OVER")
	reset_timer.start()

func victory():
	print("victory")
	UI.show_message("VICTORY!")
	reset_timer.start()

func _on_reset_timer_timeout():
	globals.new_game()

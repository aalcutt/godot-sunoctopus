extends Area2D


# Member variables
var vel = Vector2()
const SPEED = 400
const boss_shot_damage = 1

func _ready():
	set_process(true)


func start_at(dir, pos):
	rotation = dir
	position = pos
	vel = Vector2(SPEED, 0).rotated(dir)

func _process(delta):
	position = position + vel * delta
	
func _on_lifetime_timeout():
	queue_free()
	
func _on_visible_exit_screen():
	queue_free()

func _on_boss_shot_area_entered( area ):
	if(area.get_groups().has("player")):
		area.damage(boss_shot_damage)
	

func _on_boss_shot_body_entered( body ):
	if(body.get_groups().has("player")):
		body.damage(boss_shot_damage)
		queue_free()
	if(body.get_name() == "TileMap"):
		var pos = body.world_to_map(body.get_global_position())
		var id = body.get_cellv(pos)
		var body_name = body.get_tileset().tile_get_name(id)
		


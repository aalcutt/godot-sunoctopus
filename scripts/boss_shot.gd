extends Area2D


# Member variables
var vel = Vector2()
const SPEED = 200
const boss_shot_damage = 1

func _ready():
	set_process(true)

func start_at(dir, pos):
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
	if(body.get_name() == "solidTileMap"):
		var world = body.get_parent()
		var pos = position - world.position
		var angle = world.get_rotation() * -1
		var newX = pos.x * cos(angle) - pos.y * sin(angle)
		var newY = pos.x * sin(angle) + pos.y * cos(angle)
		var newPos = Vector2(newX,newY)
		pos = newPos
		var mapCoords = body.world_to_map(pos)
		#var id = body.get_cellv(mapCoords)
		#var body_name = body.get_tileset().tile_get_name(id)
		body.set_cellv(mapCoords, -1)
	queue_free()
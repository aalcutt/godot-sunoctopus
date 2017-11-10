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
	if(body.get_name() == "solidTileMap"):
		var world = body.get_parent()
		var pos = position - world.position
		print(pos)
		var angle = world.rotation * PI / 180
		print("angle")
		print(angle)
		var newY = position.x * sin(angle) + position.y * cos(angle)
		var newX = position.x * cos(angle) - position.y * sin(angle)
		var newPos = Vector2(newX,newY)
		print(newPos)
		#pos = newPos
		#y' = y*cos(a) - x*sin(a)
		#x' = y*sin(a) + x*cos(a)
		#print(pos * (world.rotation * (PI/2) ))
		var mapCoords = body.world_to_map(pos)
		print("mapCoords")
		print(mapCoords)
		#var id = body.get_cellv(mapCoords)
		#var body_name = body.get_tileset().tile_get_name(id)
		body.set_cellv(mapCoords, -1)
	queue_free()
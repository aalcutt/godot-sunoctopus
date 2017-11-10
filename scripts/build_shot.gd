extends Area2D

# Member variables
var vel = Vector2()
const SPEED = 800

#### IMPORTANT ####
# this is one collision layer 2 along with the transparent tile (id:10)

func _ready():
	set_process(true)

func start_at(dir, pos, v):
	position = pos
	vel = Vector2(SPEED, 0).rotated(dir)

func _process(delta):
	position = position + vel * delta

func _on_lifetime_timeout():
	queue_free()
	
func _on_visible_exit_screen():
	queue_free()
	
func _on_build_shot_body_entered( body ):
	if(body.get_name() == "solidTileMap"):
		queue_free()
	elif(body.get_name() == "transparentTileMap"):
		var world = body.get_parent()
		var pos = position - world.position
		var angle = world.get_rotation() * -1
		var newX = pos.x * cos(angle) - pos.y * sin(angle)
		var newY = pos.x * sin(angle) + pos.y * cos(angle)
		var newPos = Vector2(newX,newY)
		pos = newPos

		var mapCoords = body.world_to_map(pos)
		var id = body.get_cellv(mapCoords)
		if(id == 10): #the transparent block
			body.get_parent().get_node("solidTileMap").set_cellv(mapCoords, 0)
			queue_free()


func _on_build_shot_area_entered( area ):
	pass # replace with function body

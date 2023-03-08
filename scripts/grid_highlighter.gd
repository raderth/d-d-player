extends Sprite2D

var my_scale = 1

@export
var tile_size = 64

func _ready():
	texture = load("res://terrain/dark_plains.png")
	get_parent().get_node("CanvasLayer/ui/Container/Window").change_texture.connect(texture_swap)

func _process(delta):
	position = (get_global_mouse_position() - get_parent().position).snapped(Vector2(tile_size,tile_size))
	scale = Vector2(my_scale,my_scale)
	
	if Input.is_action_just_released("rotate"):
		rotation += deg_to_rad(90)

func _on_map_the_scale(scale_factor,positon_modifier):
	my_scale = scale_factor
	tile_size *= positon_modifier

func texture_swap(my_sprite,random,my_layer):
	var the_texture
	if not random:
		the_texture = "res://terrain/{text}.png".format({"text": my_sprite})
	else:
		var directory = "res://terrain/{text}".format({"text": my_sprite})
		var dir = DirAccess.open(directory)
		var files = []
		if dir:
			dir.list_dir_begin()
			var file_name = dir.get_next()
			while file_name != "":
				if dir.current_is_dir():
					pass
				else:
					if not file_name.ends_with("import"):
						files.append(file_name)
				file_name = dir.get_next()
			the_texture = directory +"/"+ files[0]
	texture = load(the_texture)

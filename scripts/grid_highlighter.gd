extends Sprite2D

var my_scale = 1

@export
var tile_size = 64

func _ready():
	texture = load("res://terrain/dark_plains.png")
	get_parent().get_node("CanvasLayer/ui/Container/Window/main").texture_switch.connect(texture_swap)

func _process(delta):
	position = (get_global_mouse_position() - get_parent().position).snapped(Vector2(tile_size,tile_size))
	scale = Vector2(my_scale,my_scale)
	
	if Input.is_action_just_released("rotate"):
		rotation += deg_to_rad(90)

func _on_map_the_scale(scale_factor,positon_modifier):
	my_scale = scale_factor
	tile_size *= positon_modifier

func texture_swap(my_sprite):
	texture = load(my_sprite)


func _on_map_swap_highlight(child):
	texture = child

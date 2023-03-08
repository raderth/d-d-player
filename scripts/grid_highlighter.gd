extends Sprite2D

var my_scale = 1


@export
var tile_size = 64

func _process(delta):
	position = (get_global_mouse_position() - get_parent().position).snapped(Vector2(tile_size,tile_size))
	scale = Vector2(my_scale,my_scale)

func _on_map_the_scale(scale_factor,positon_modifier):
	my_scale = scale_factor
	tile_size *= positon_modifier

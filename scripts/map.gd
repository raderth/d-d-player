extends Node2D

signal the_scale(scale_factor,position_modifier)

@export
var tile_size = 64

var old_pos
var used_positions = []
var blocked = false
var children = []

@export
var my_scale = 1

func _process(delta):
	#placing tiles
	if Input.is_action_pressed("click") and not blocked:
		var tile_position = (get_global_mouse_position() - position).snapped(Vector2(tile_size,tile_size))
		var used = false
		for i in used_positions:
			if tile_position == i:
				used = true
		if not used:
			used_positions.append(tile_position)
			var my_sprite = Sprite2D.new()
			children.append(my_sprite)
			add_child(my_sprite)
			var texture = load("res://terrain/dark_plains.png")
			my_sprite.set_texture(texture)
			my_sprite.position = tile_position
			my_sprite.scale = Vector2(my_scale,my_scale)
	#panning
	if Input.is_action_pressed("move_screen"):
		var direction = get_global_mouse_position() - old_pos
		position += direction
	old_pos = get_global_mouse_position()
	
	#ZOOOOOOM
	var scale_change = false
	var pos_mod
	if Input.is_action_just_released("scroll_down"):
		my_scale *= 0.9
		pos_mod = 0.9
		scale_change = true
	if Input.is_action_just_released("scroll_up"):
		my_scale *= 1.1
		pos_mod = 1.1
		scale_change = true
	if scale_change:
		var old_mouse_pos = get_global_mouse_position() - position
		var new_mouse_pos = (get_global_mouse_position() - position) * pos_mod
		var direction_zoom = new_mouse_pos - old_mouse_pos
		emit_signal("the_scale",my_scale,pos_mod)
		tile_size *= pos_mod
		for child in children:
			child.scale = Vector2(my_scale,my_scale)
			
			var index = used_positions.find(child.position,0)
			used_positions.remove_at(index)
			child.position *= pos_mod
			used_positions.append(child.position)
			
		position -= direction_zoom


func _on_area_2d_mouse_entered():
	blocked = true


func _on_area_2d_mouse_exited():
	blocked = false

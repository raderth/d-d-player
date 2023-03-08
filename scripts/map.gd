extends Node2D

signal the_scale(scale_factor,position_modifier)

@export
var tile_size = 64

var tool = 'pen'
var old_pos
var used_positions_1 = []
var used_positions_2 = []
var blocked = false
var blocked_by_window = false
var children = []
var directory
var files
var my_rotation = 0

@export
var my_scale = 1

var texture = "res://terrain/dark_plains.png"
var is_random = false
var layer = 1

func _ready():
	get_node("CanvasLayer/ui/Container/Window").change_texture.connect(texture_swap)

func texture_swap(my_sprite,random,my_layer):
	blocked_by_window = false
	if not random:
		texture = "res://terrain/{text}.png".format({"text": my_sprite})
	else:
		directory = "res://terrain/{text}".format({"text": my_sprite})
		var dir = DirAccess.open(directory)
		files = []
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

	is_random = random
	layer = my_layer

func _process(delta):
	if Input.is_action_just_released("rotate"):
		my_rotation += 90
		if my_rotation == 360:
			my_rotation = 0
	#placing tiles
	if Input.is_action_pressed("click") and not blocked and not blocked_by_window:
		var tile_position = (get_global_mouse_position() - position).snapped(Vector2(tile_size,tile_size))
		if tool == 'pen':
			var used = false
			if layer == 1:
				for i in used_positions_1:
					if round(tile_position) == round(i):
						used = true
			elif layer == 2:
				for i in used_positions_2:
					if round(tile_position) == round(i):
						used = true
			if not used:
				if layer == 1:
					used_positions_1.append(tile_position)
				elif layer == 2:
					used_positions_2.append(tile_position)
				var my_sprite = Sprite2D.new()
				children.append(my_sprite)
				add_child(my_sprite)
				if is_random:
					texture = directory +"/"+ files[randi() % files.size()]
				my_sprite.set_texture(load(texture))
				my_sprite.position = tile_position
				my_sprite.scale = Vector2(my_scale,my_scale)
				my_sprite.z_index = layer
				my_sprite.rotation = deg_to_rad(my_rotation)
		if tool == 'eraser':
			for child in children:
				if round(child.position) == round(tile_position):
					if layer == 1:
						var index0 = used_positions_1.find(tile_position, 0)
						used_positions_1.remove_at(index0)
					elif layer == 2:
						var index0 = used_positions_2.find(tile_position, 0)
						used_positions_2.remove_at(index0)
					var index1 = children.find(child, 0)
					children.remove_at(index1)
					
					# remove child node from the scene tree
					remove_child(child)
					child.queue_free()
					
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
			if layer == 1:
				var index = used_positions_1.find(child.position,0)
				used_positions_1.remove_at(index)
			elif layer == 2:
				var index = used_positions_2.find(child.position,0)
				used_positions_2.remove_at(index)
			child.position *= pos_mod
			if layer == 1:
				used_positions_1.append((child.position*pos_mod)) # update used_positions_1 array with the new position
			elif layer == 2:
				used_positions_2.append((child.position*pos_mod)) # update used_positions_2 array with the new position
		position -= direction_zoom


func _on_area_2d_mouse_entered():
	blocked = true


func _on_area_2d_mouse_exited():
	blocked = false


func _on_pen_pressed():
	tool = 'pen'


func _on_eraser_pressed():
	tool = 'eraser'




func _on_image_pressed():
	blocked_by_window = true


func _on_window_close_requested():
	blocked_by_window = false

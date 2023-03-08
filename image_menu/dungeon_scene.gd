extends GridContainer
signal load_sprite(my_sprite,random,my_layer)
signal change_scene(my_scene)



func _on_blank_pressed():
	emit_signal("load_sprite","dungeon/blank",false,1)


func _on_chest_pressed():
	emit_signal("load_sprite","dungeon/chest",false,2)


func _on_edge_close_pressed():
	emit_signal("load_sprite","dungeon/edge_close",false,1)


func _on_edge_corner_pressed():
	emit_signal("load_sprite","dungeon/edge_corner",false,1)


func _on_edge_far_pressed():
	emit_signal("load_sprite","dungeon/edge_far",false,1)


func _on_rock_1_pressed():
	emit_signal("load_sprite","dungeon/rock_1",false,1)


func _on_rock_2_pressed():
	emit_signal("load_sprite","dungeon/rock_2",false,1)

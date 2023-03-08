extends GridContainer
signal change_scene(my_scene)
signal load_sprite(my_sprite,random,my_layer)



func _on_texture_button_pressed():
	emit_signal("load_sprite","scrub_forest",true,2)


func _on_conifer_pressed():
	emit_signal("load_sprite","conifer_forest/conifer_forest_outer_extra_1",false,2)

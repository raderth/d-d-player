extends GridContainer
signal load_sprite(my_sprite,random,my_layer)
signal change_scene(my_scene)


func _on_dark_plains_pressed():
	emit_signal("load_sprite","dark_plains",false,1)


func _on_plains_pressed():
	emit_signal("load_sprite","plains",false,1)


func _on_mountains_pressed():
	emit_signal("load_sprite","mountains",false,2)


func _on_water_pressed():
	emit_signal("load_sprite","water",false,1)

extends GridContainer
signal change_scene(my_scene)
signal load_sprite(my_sprite,random,my_layer)




func _on_trees_pressed():
	emit_signal("change_scene", "trees")


func _on_flat_pressed():
	emit_signal("change_scene", "basic")


func _on_dungeon_pressed():
	emit_signal("change_scene", "dungeon")

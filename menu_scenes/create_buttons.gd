extends Control
signal change_scene(scene_path)
signal load_level(path)




func _on_new_pressed():
	get_tree().change_scene_to_file("res://map.tscn")


func _on_back_pressed():
	emit_signal("change_scene", "res://menu_scenes/main_buttons.tscn")


func _on_file_dialog_load_scene(path):
	emit_signal("load_level", path)

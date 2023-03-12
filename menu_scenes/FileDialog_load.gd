extends FileDialog
signal load_scene(path)


func _on_load_pressed():
	visible = true



func _on_confirmed():
	emit_signal("load_scene", current_path)

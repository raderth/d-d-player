extends Control
signal change_scene(scene_path)


func _on_join_pressed():
	emit_signal("change_scene", "res://menu_scenes/join_buttons.tscn")


func _on_host_pressed():
	emit_signal("change_scene", "res://menu_scenes/host_buttons.tscn")


func _on_create_campaign_pressed():
	emit_signal("change_scene", "res://menu_scenes/create_buttons.tscn")

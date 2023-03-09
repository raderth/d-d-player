extends FileDialog
signal file_dialog_open(is_open)
signal directory(path)

func _ready():
	current_path = "C:/"
	current_file = "my_level.txt"
	visible = false
	


func _on_save_pressed():
	print("save")
	visible = true
	emit_signal("file_dialog_open", true)


func _on_confirmed():
	emit_signal("file_dialog_open", false)
	emit_signal("directory", current_path)

extends Button
var my_file

func _init(file,button):
	set_process(true)
	my_file = file
	button.pressed.connect(button_p)

func button_p():
	Constants.set_path_for_tiles(my_file)

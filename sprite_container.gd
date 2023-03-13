extends GridContainer
signal texture_switch(path)

var current_children = []
var path = "res://image_menu/"

func _process(delta):
	var the_path = Constants.get_path_for_tiles()
	if the_path != "":
		if "png" in the_path:
			emit_signal("texture_switch",path+"/"+the_path)
		for child in current_children:
			remove_child(child)
			child.queue_free()
		current_children = []
		path = path + "/"+ the_path
		Constants.set_path_for_tiles("")
		if not "png" in the_path:
			load_new_path(path)
		
func pressed_button():
	print("pressed")

func load_new_path(path):
	for file in dir_contents(path):
		if not "import" in file:
			if not "." in file:
				var directory = Button.new()
				directory.text = file
				current_children.append(directory)
				var script = load("res://scripts/tile_explorer.gd").new(file,directory)
				directory.set_script(script)
				add_child(directory)
			else:
				var tile = TextureButton.new()
				current_children.append(tile)
				tile.texture_normal = load(path+"/"+file)
				var script = load("res://scripts/tile_explorer.gd").new(file,tile)
				tile.set_script(script)
				add_child(tile)

			
func dir_contents(path):
	var files = []
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				files.append(file_name)
			else:
				files.append(file_name)
			file_name = dir.get_next()
	return(files)


func _on_window_load_initial_tiles():
	path = "res://image_menu/"
	load_new_path(path)

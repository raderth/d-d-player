extends Node
var last_scene

func _ready():
	last_scene = get_node("main_buttons")
	last_scene.change_scene.connect(scene_changer)

func scene_changer(scene):
	last_scene.queue_free()
	var Loaded_scene = load(scene).instantiate()
	add_child(Loaded_scene)
	Loaded_scene.z_index = 2
	last_scene = Loaded_scene
	if last_scene.has_signal("change_scene"):
		last_scene.change_scene.connect(scene_changer)
	if last_scene.has_signal("load_level"):
		last_scene.load_level.connect(load_my_level)
	
func load_my_level(path):
	Constants.set_load_path(path)
	get_tree().change_scene_to_file("res://map.tscn")

extends Window
signal change_texture(texture)

var path = "res://image_menu/"
var loaded = []

func _ready():
	visible = false
	remove_child(get_child(0))
	


func _on_image_pressed():
	visible = true
	var scene = load("res://image_menu/main.tscn").instantiate()
	add_child(scene)
	scene.change_scene.connect(scene_changer)
	scene.load_sprite.connect(sprite_changer)


func _on_close_requested():
	visible = false
	remove_child(get_child(0))

func scene_changer(my_scene):
	remove_child(get_child(0))
	var the_scene = load("res://image_menu/{file}.tscn".format({"file": my_scene})).instantiate()
	add_child(the_scene)
	the_scene.change_scene.connect(scene_changer)
	the_scene.load_sprite.connect(sprite_changer)
	
func sprite_changer(my_sprite,random,my_layer):
	remove_child(get_child(0))
	emit_signal("change_texture",my_sprite,random,my_layer)
	visible = false




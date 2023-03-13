extends Window
signal change_texture(texture, layer)
signal load_initial_tiles

var path = "res://image_menu/"

func _ready():
	visible = false


func _on_image_pressed():
	visible = true
	emit_signal("load_initial_tiles")


func _on_close_requested():
	visible = false

	
func sprite_changer(my_sprite,my_layer):
	emit_signal("change_texture",my_sprite,my_layer)
	visible = false




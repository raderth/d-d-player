extends TextureButton


func _ready():
	disabled = true


func _on_eraser_pressed():
	disabled = false


func _on_pressed():
	disabled = true

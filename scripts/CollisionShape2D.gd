extends CollisionShape2D

func _ready():
	shape.extents = Vector2((get_viewport().size.x/15),(get_viewport().size.y))
	position = Vector2((get_viewport().size.x/15 * 0.5),(get_viewport().size.y * 0.5))

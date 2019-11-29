tool
extends Sprite

export var update: bool = false setget set_update

func _draw():
	var max_length = 0
	var cur = self
	while true:
		max_length += cur.get_rect().size.y
		if cur.get_child_count() == 0:
			break
		cur = cur.get_child(0)
	
	draw_arc(Vector2(), max_length, 0, 2*PI, 100, Color.red, 2)

func _enter_tree():
	update()

func set_update(to: bool):
	update = false
	if to:
		var cur = self
		while true:
			cur.rotation_degrees = -45
			if cur.get_child_count() == 0:
				break
			cur = cur.get_child(0)

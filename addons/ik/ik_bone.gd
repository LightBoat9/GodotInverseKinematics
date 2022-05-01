tool
extends Node2D

export var length: int = 10 setget set_length

func _draw() -> void:
	draw_rect(Rect2(Vector2(0, -0.5), Vector2(length, 1)), Color.black)
	draw_rect(Rect2(Vector2(0, -0.5), Vector2(1, 1)), Color.white)
	draw_rect(Rect2(Vector2(length-1, -0.5), Vector2(1, 1)), Color.white)
	
func _init():
	add_to_group("ik_bones")
	
func _enter_tree():
	update_position()

func set_length(to: int) -> void:
	length = to
	update()
	update_position()
	
func update_position():
	if is_inside_tree() and get_parent().is_in_group("ik_bones"):
		position = Vector2(get_parent().length, 0)
		
	for child in get_children():
		if child.is_in_group("ik_bones"):
			child.update_position()

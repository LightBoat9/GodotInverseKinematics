tool
extends EditorPlugin

const IKBone: GDScript = preload("res://addons/ik/ik_bone.gd")

func _enter_tree():
	add_custom_type("IKBone", "Node2D", IKBone, null)

func _exit_tree():
	remove_custom_type("IKBone")

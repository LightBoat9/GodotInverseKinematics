tool
extends Position2D

# My attempt at IK with FABRIK
# http://www.andreasaristidou.com/publications/papers/FABRIK.pdf
	
export(float) var error = 0.01
export(int) var recurse_limit = 100
	
func _process(delta):
	ik()
	
	if not Engine.editor_hint:
		global_position = get_global_mouse_position()
		
func ik():
	var top = $"../Bone"
	var bones = []
	while top:
		bones.append(top)
		if top.get_child_count() == 0:
			break
		top = top.get_child(0)
		
	var full_length = 0
	for bone in bones:
		full_length += bone.get_rect().size.y
		
	if bones[0].global_position.distance_to(global_position) > full_length:
		for i in range(len(bones)):
			var ang = bones[i].global_position.angle_to_point(global_position) + deg2rad(90)
			bones[i].global_rotation = ang
	else:
		var limit = recurse_limit
		
		while limit > 0 and bones[-1].global_position.distance_to(global_position) > error:
			var pos = []
			for bone in bones:
				pos.append(bone.global_position)
			pos.append(global_position)
			
			for i in range(len(pos)-2, -1, -1):
				pos[i] = pos[i+1] + (pos[i] - pos[i+1]).normalized() * bones[i].get_rect().size.y
			
			pos[0] = bones[0].global_position
			for i in range(1, len(pos)-1):
				pos[i] = pos[i-1] + (pos[i] - pos[i-1]).normalized() * bones[i-1].get_rect().size.y
			
			for i in range(len(pos)-1):
				bones[i].global_rotation = bones[i].global_position.angle_to_point(pos[i+1]) + deg2rad(90)
				
			limit -= 1

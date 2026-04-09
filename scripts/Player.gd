extends CharacterBody3D

@export var aim_ray: RayCast3D
const HOLE = preload("uid://tpbbr7m0pveq")

const SPEED:float = 3.0
const CAM_SPEED:float = 25.0
const JUMP_VELOCITY = 4.5



func _physics_process(delta: float) -> void:
	
	var direction = Input.get_vector("m_left","m_right","m_fwd","m_back")
	if direction:
		velocity = Vector3(direction.x,0,direction.y).normalized() * SPEED
	else:
		velocity = Vector3.ZERO
	
	
	var camera_input_dir := Input.get_vector("c_left","c_right","c_up","c_down")
	if camera_input_dir:
		rotation_degrees.y -= camera_input_dir.x * CAM_SPEED * delta
		%Cam.rotation_degrees.x += camera_input_dir.y * CAM_SPEED * delta
		
	move_and_slide()	
	
	if Input.is_action_just_pressed("shoot"):
		shoot()
		
		
	
#==============================================
func shoot() -> void:
	print("Shooting")
	if aim_ray.is_colliding():
		print("Hit")
		var collider:Node3D = aim_ray.get_collider()
		var shape = aim_ray.get_collider_shape()
		print(shape)
		if shape == 1: #bull			
			var tar:Node3D = collider.get_parent()
			if tar.has_method("reset"):			
				tar.reset()
		else:	
			var collision_point = aim_ray.get_collision_point()
			var collision_normal = aim_ray.get_collision_normal()
			print(collision_point)
			print(collision_normal)
			place_hole(collision_point,collision_normal)
		
			
		
		
func place_hole(position:Vector3, normal:Vector3) -> void:
	
	var hole:Node3D = HOLE.instantiate()
	get_tree().root.add_child(hole)
	hole.global_position = position
	print("gto = ",hole.global_transform.origin)
	print("look at = ",hole.global_transform.origin + normal)
	hole.look_at(hole.global_transform.origin + normal,Vector3.UP)
	hole.rotate_object_local(Vector3(1,0,0),90)

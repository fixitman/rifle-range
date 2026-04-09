extends CharacterBody3D

@onready var aim_ray: RayCast3D = $Cam/AimRay
const HOLE = preload("uid://tpbbr7m0pveq")

var MOVE_SPEED:float = 3.0
var CAM_SPEED:float = 10
const JUMP_VELOCITY = 4.5




func _physics_process(delta: float) -> void:
	
	var velocity_direction = Input.get_vector("m_left","m_right","m_fwd","m_back")
	var y_rotation_direction = Input.get_axis("c_left","c_right")
	var x_rotation_direction = Input.get_axis("c_up","c_down")
	
	rotation_degrees.y -= y_rotation_direction * CAM_SPEED * delta
	%Cam.rotate_x( deg_to_rad( x_rotation_direction * CAM_SPEED * delta))
	
	velocity = transform.basis * Vector3(velocity_direction.x, 0, velocity_direction.y) * MOVE_SPEED
	
	
	
	
		
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




func _on_cam_speed_value_changed(value: float) -> void:
	CAM_SPEED = value


func _on_mov_speed_value_changed(value: float) -> void:
	MOVE_SPEED = value

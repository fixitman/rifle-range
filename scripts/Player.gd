extends CharacterBody3D


const SPEED = 50.0

const JUMP_VELOCITY = 4.5
@export var aim_ray: RayCast3D
const HOLE = preload("uid://tpbbr7m0pveq")


func _physics_process(delta: float) -> void:
	
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if input_dir:
		rotation_degrees.y -= input_dir.x * SPEED * delta
		%Cam.rotation_degrees.x += input_dir.y * SPEED * delta
		
#==============================================
func _on_shoot_button_down() -> void:
	print("Shooting")
	if aim_ray.is_colliding():
		print("Hit")
		var collider:Node3D = aim_ray.get_collider()
		var tar:Node3D = collider.get_parent()
		#if tar.has_method("reset"):			
			#tar.reset()
			
		var collision_point = aim_ray.get_collision_point()
		var collision_normal = aim_ray.get_collision_normal()
		print(collision_point)
		print(collision_normal)
		
		var hole:Node3D = HOLE.instantiate()
		get_tree().root.add_child(hole)
		hole.global_position = collision_point
		print("gto = ",hole.global_transform.origin)
		print("look at = ",hole.global_transform.origin + collision_normal)
		hole.look_at(hole.global_transform.origin + collision_normal,Vector3.UP)
		hole.rotate_object_local(Vector3(1,0,0),90)
		
		
		
		
#============================================
func _on_button_button_down() -> void:
	pass # Replace with function body.

extends CharacterBody3D

@onready var aim_ray: RayCast3D = $Cam/AimRay
@onready var animation_player: AnimationPlayer = $AnimationPlayer
const HOLE = preload("uid://tpbbr7m0pveq")

const JUMP_VELOCITY = 4.5
var move_speed:float = 3.0
var camera_speed:float = 10
var settings: Settings

func _ready() -> void:
	update_settings()
	settings.settings_changed.connect(_on_settings_changed)

func _physics_process(delta: float) -> void:
	
	var velocity_direction = Input.get_vector("m_left","m_right","m_fwd","m_back")
	var y_rotation_direction = Input.get_axis("c_left","c_right")
	var x_rotation_direction = Input.get_axis("c_up","c_down")
	
	rotation_degrees.y -= y_rotation_direction * camera_speed * delta
	%Cam.rotate_x( deg_to_rad( x_rotation_direction * camera_speed * delta))
	
	velocity = transform.basis * Vector3(velocity_direction.x, 0, velocity_direction.y) * move_speed
		
	move_and_slide()	
	
	if Input.is_action_just_pressed("shoot"):
		shoot()

func shoot() -> void:
	print("Shooting")
	animation_player.play("fire_pistol")
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

func update_settings():
	settings = Settings.load_or_create()
	camera_speed = settings.camera_speed
	move_speed = settings.move_speed

func _on_settings_changed():
	update_settings()

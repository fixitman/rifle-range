extends CharacterBody3D

@onready var aim_ray: RayCast3D = $Cam/AimRay
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var weapon: Node3D = %Weapon.get_child(0)
@onready var cam: Camera3D = %Cam

const HOLE = preload("uid://tpbbr7m0pveq")

const JUMP_VELOCITY = 4.5
var move_speed:float = 3.0
var camera_speed:float = 10
var camera_accel:float = 28
var current_camera_speed:float = 0
var current_camera_speed_x:float = 0
var aimed:bool = false

var settings: Settings

func _ready() -> void:
	update_settings()
	settings.settings_changed.connect(_on_settings_changed)

func _physics_process(delta: float) -> void:
	
	rotate_camera(delta)
	
	handle_buttons()
	
	var velocity_direction = Input.get_vector("m_left","m_right","m_fwd","m_back")
	velocity = transform.basis * Vector3(velocity_direction.x, 0, velocity_direction.y) * move_speed
	move_and_slide()	
	
	

func rotate_camera(delta:float):
	var y_rotation_direction = Input.get_axis("c_left","c_right")
	var x_rotation_direction = Input.get_axis("c_up","c_down")
	
	#rotation_degrees.y -= y_rotation_direction * camera_speed * delta
	if y_rotation_direction:
		var target_camera_speed = camera_speed * -y_rotation_direction
		current_camera_speed = move_toward(current_camera_speed,target_camera_speed,camera_accel * delta)
		rotate_y(deg_to_rad(current_camera_speed * delta))
	else:
		current_camera_speed = 0
	
	if x_rotation_direction:
		var target_camera_speed = camera_speed * x_rotation_direction
		current_camera_speed_x = move_toward(current_camera_speed_x,target_camera_speed,camera_accel * delta)
		%Cam.rotate_x( deg_to_rad( current_camera_speed_x * delta))
	else:
		current_camera_speed_x = 0

func shoot() -> void:
	#print("Shooting")
	if weapon && weapon.has_method("shoot"):
		weapon.shoot()
	if aim_ray.is_colliding():
		#print("Hit")
		var collider:Node3D = aim_ray.get_collider()
		var shape = aim_ray.get_collider_shape()
		#print(collider)
		if collider.name == "Head": 		
			var tar:Node3D = collider.get_parent().get_parent()
			if tar.has_method("reset"):			
				tar.reset()
		else:	
			var collision_point = aim_ray.get_collision_point()
			var collision_normal = aim_ray.get_collision_normal()
			#print(collision_point)
			#print(collision_normal)
			place_hole(collision_point,collision_normal)

func handle_buttons():
	if Input.is_action_just_pressed("shoot"):
		shoot()
		
	if Input.is_action_just_pressed("aim"): 
		if aimed:
			un_aim()
			aimed = false
		else:
			aim()
			aimed = true

func place_hole(position:Vector3, normal:Vector3) -> void:
	
	var hole:Node3D = HOLE.instantiate()
	get_tree().root.add_child(hole)
	hole.global_position = position
	#print("gto = ",hole.global_transform.origin)
	#print("look at = ",hole.global_transform.origin + normal)
	hole.look_at(hole.global_transform.origin + normal,Vector3.UP)
	hole.rotate_object_local(Vector3(1,0,0),90)

func update_settings():
	settings = Settings.load_or_create()
	camera_speed = settings.camera_speed
	move_speed = settings.move_speed
	camera_accel = settings.camera_accel

func _on_settings_changed():
	update_settings()
	
func aim():
	if weapon.has_method("aim"):
		weapon.aim()
		%Cam.fov = 30
		pass 
		
func un_aim():
	if weapon.has_method("un_aim"):
		weapon.un_aim()
		%Cam.fov = 75

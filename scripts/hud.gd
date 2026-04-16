extends Control

@onready var camera_speed: SpinBox = %CameraSpeed
@onready var move_speed: SpinBox = %MoveSpeed
@onready var camera_accel: SpinBox = $CameraAccel


var settings: Settings

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	camera_speed.get_line_edit().focus_mode = Control.FOCUS_NONE
	camera_speed.get_line_edit().connect("text_changed",on_text_changed)
	
	move_speed.get_line_edit().focus_mode = Control.FOCUS_NONE
	move_speed.get_line_edit().connect("text_changed",on_text_changed)
	
	camera_accel.get_line_edit().focus_mode = Control.FOCUS_NONE
	camera_accel.get_line_edit().connect("text_changed",on_text_changed)
	
	settings = Settings.load_or_create()
	if camera_speed:
		camera_speed.value = settings.camera_speed
	if move_speed:
		move_speed.value = settings.move_speed
	if camera_accel:
		camera_accel.value = settings.camera_accel

func _on_camera_speed_value_changed(value: float) -> void:
	settings.camera_speed = value
	settings.save()


func _on_move_speed_value_changed(value: float) -> void:
	settings.move_speed = value
	settings.save()
	
func on_text_changed():
	release_focus()


func _on_camera_accel_value_changed(value: float) -> void:
	settings.camera_accel = value
	settings.save()

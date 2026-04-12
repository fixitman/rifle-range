extends Control

@onready var camera_speed: SpinBox = %CameraSpeed
@onready var move_speed: SpinBox = %MoveSpeed


var settings: Settings

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	camera_speed.get_line_edit().focus_mode = Control.FOCUS_NONE
	camera_speed.get_line_edit().connect("text_entered",on_text_entered)
	
	move_speed.get_line_edit().focus_mode = Control.FOCUS_NONE
	move_speed.get_line_edit().connect("text_entered",on_text_entered)
	
	settings = Settings.load_or_create()
	if camera_speed:
		camera_speed.value = settings.camera_speed
	if move_speed:
		move_speed.value = settings.move_speed


func _on_camera_speed_value_changed(value: float) -> void:
	settings.camera_speed = value
	settings.save()


func _on_move_speed_value_changed(value: float) -> void:
	settings.move_speed = value
	settings.save()
	
func on_text_entered():
	release_focus()

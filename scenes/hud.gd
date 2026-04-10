extends Control

@onready var camera_speed: SpinBox = %CameraSpeed
@onready var move_speed: SpinBox = %MoveSpeed




var settings: Settings

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	settings = Settings.load_or_create()
	if camera_speed:
		camera_speed.value = settings.camera_speed
	if move_speed:
		move_speed.value = settings.move_speed


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_camera_speed_value_changed(value: float) -> void:
	settings.camera_speed = value
	settings.save()


func _on_move_speed_value_changed(value: float) -> void:
	settings.move_speed = value
	settings.save()

extends Node3D

var triggered:bool = false
var height:float = 2.0
@export var row:int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	trigger()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func trigger() -> void:
	if !triggered:
		%HitBox.global_translate(Vector3(0.0,height,0.0))
		triggered = true
		
func reset() -> void:
	if triggered:
		%HitBox.global_translate(Vector3(0.0,-height,0.0))
		triggered = false
	


func _on_button_button_down() -> void:
	if triggered:
		reset()
	else:
		trigger()

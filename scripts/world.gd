extends Node3D

@export var targets: Array[Node3D]



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_button_down() -> void:
	for target in targets:
		if !target.triggered:
			target.trigger()
		

func _on_shoot_button_down() -> void:
	pass # Replace with function body.

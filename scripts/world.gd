extends Node3D

var targets:Array[Node] = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	targets = get_tree().get_nodes_in_group("targets")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_button_down() -> void:
	for target in targets:
		if !target.triggered:
			target.trigger()
		

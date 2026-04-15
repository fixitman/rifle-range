extends Node3D

var targets:Array[Node] = []


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	targets = get_tree().get_nodes_in_group("targets")
	reset_targets()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("targets"):
		reset_targets()
		


func reset_targets() -> void:
	for target in targets:
		if !target.triggered:
			target.trigger()
		

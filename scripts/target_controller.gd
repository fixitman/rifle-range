extends Node
const TARGET = preload("uid://clbilrw3wi3nw")
const DISTANCE = -8
const NUM_TARGETS = 10
var targets: Array[Target] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initialize_targets()
	show_random_target()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
func initialize_targets():
	for x in range(NUM_TARGETS):
		var t:Node3D  = TARGET.instantiate()
		t.position = Vector3(x*2 + .6 + -10, 0, DISTANCE)
		t.add_to_group("targets")
		add_child(t)
		targets.insert(x,t)

	show_all_targets()
	await get_tree().create_timer(1.5).timeout
	hide_all_targets()


func hide_all_targets():
	for target in targets:
		if target.showing:
			await get_tree().create_timer(.02).timeout
			target.hide_target()

func show_all_targets() -> void:
	for target in targets:
		if !target.showing:
			#await get_tree().create_timer(.2).timeout
			target.show_target()
		
func show_random_target():
	await get_tree().create_timer(randf_range(2,5)).timeout
	var t = randi_range(0,targets.size()-1)
	targets[t].show_target()
	
func on_target_hit(t: Target):
	t.hide()
	targets.erase(t)
	if targets.size() > 0:
		show_random_target()

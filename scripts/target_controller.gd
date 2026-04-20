extends Node
const TARGET = preload("res://scenes/target.tscn")
const DISTANCE = -10
const WIDTH = 20
const TARGET_WIDTH = .67
const NUM_TARGETS:int = 8
var targets: Array[Target] = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	initialize_targets()
	show_random_target()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("targets"):
		initialize_targets()
	pass
func initialize_targets():
	if NUM_TARGETS <= 0:
		return
		
	var space:float = (WIDTH - (NUM_TARGETS*TARGET_WIDTH))/(NUM_TARGETS + 1)
	
	for i in range(NUM_TARGETS):
		var x = space + (i+.5) * TARGET_WIDTH + (space * i) - WIDTH/2.0
		var t:Node3D  = TARGET.instantiate()
		t.position = Vector3(x, 0, DISTANCE)
		t.add_to_group("targets")
		add_child(t)
		targets.insert(i,t)

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
	await get_tree().create_timer(2.0).timeout
	var t = randi_range(0,targets.size()-1)
	targets[t].show_target()
	
func on_target_hit(t: Target):
	t.hide_target()
	targets.erase(t)
	if targets.size() > 0:
		show_random_target()

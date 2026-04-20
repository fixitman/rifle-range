class_name Weapon
extends Node3D

const CLIP_SIZE: int = 10
enum FIRING_MODES {SEMI}

var rounds_remaining = CLIP_SIZE
var can_shoot:bool = false
var firing_mode = FIRING_MODES.SEMI

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func shoot():
	pass
	
func reload():
	pass
	
func aim():
	pass
	
func un_aim():
	pass

func draw():
	pass
func holster():
	pass
	
func change_firing_mode():
	firing_mode = firing_mode + 1 % FIRING_MODES.size()
	pass

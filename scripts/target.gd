extends Node3D

var triggered:bool = false
var height:float = 2.0
const RESET_ROTATION := 90.0
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	trigger()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func trigger() -> void:
	if !triggered:
		#%HitBox.global_translate(Vector3(0.0,height,0.0))
		#%HitBox.global_rotate(Vector3.UP,-PI/2)
		animation_player.play("trigger")
		triggered = true
		
func reset() -> void:
	if triggered:
		#%HitBox.global_translate(Vector3(0.0,-height,0.0))
		#%HitBox.global_rotate(Vector3.UP,PI/2)
		animation_player.play("reset")
		triggered = false
	

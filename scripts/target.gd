class_name Target
extends Node3D

var showing:bool = false
var height:float = 2.0
const RESET_ROTATION := 90.0
@onready var animation_player: AnimationPlayer = $AnimationPlayer



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide_target()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func show_target() -> void:
	if !showing:
		#%HitBox.global_translate(Vector3(0.0,height,0.0))
		#%HitBox.global_rotate(Vector3.UP,-PI/2)
		visible = true
		animation_player.play("show")
		
		showing = true
		
func hide_target() -> void:
	if showing:
		#%HitBox.global_translate(Vector3(0.0,-height,0.0))
		#%HitBox.global_rotate(Vector3.UP,PI/2)
		animation_player.play("hide")
		visible = false
		showing = false
	

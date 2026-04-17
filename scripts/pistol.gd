extends Node3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var audio_stream_player_3d: AudioStreamPlayer3D = $AudioStreamPlayer3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func draw():
	animation_player.play("draw")
	
func holster():
	animation_player.play_backwards("draw")
	

func shoot():
	audio_stream_player_3d.play()
	animation_player.play("fire")
	
	
func aim():
	animation_player.play("aim")
	
func un_aim():
	animation_player.play_backwards("aim")


func _on_timer_timeout() -> void:
	holster()

extends Node3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var shoot_sound: AudioStreamPlayer3D = $ShootSound
@onready var reload_sound: AudioStreamPlayer3D = $ReloadSound


const CLIP_SIZE = 10

enum FIRING_MODE {SEMI}
var mode:FIRING_MODE
var bullets_left:int
var can_shoot = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bullets_left = CLIP_SIZE
	mode = mode + 1 % FIRING_MODE.size()
	print(mode)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func draw():
	animation_player.play("draw")
	await animation_player.animation_finished
	can_shoot = true
	
func holster():
	can_shoot = false
	animation_player.play_backwards("draw")
	

func shoot():
	if !can_shoot:
		return
	shoot_sound.play()
	animation_player.play("fire")
	
	bullets_left -= 1
	print(bullets_left)
	if bullets_left <= 0:
		reload()
	
func reload():
	print("reloading...")
	can_shoot = false
	await get_tree().create_timer(.5).timeout
	reload_sound.play()
	animation_player.play_backwards("draw")
	await animation_player.animation_finished
	await get_tree().create_timer(.75).timeout
	animation_player.play("draw")
	await animation_player.animation_finished
	can_shoot = true
	bullets_left = CLIP_SIZE

func aim():
	animation_player.play("aim")
	
func un_aim():
	animation_player.play_backwards("aim")


#func _on_timer_timeout() -> void:
	#holster()

extends Weapon
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var shoot_sound: AudioStreamPlayer3D = $ShootSound
@onready var reload_sound: AudioStreamPlayer3D = $ReloadSound


enum FIRING_MODE {SEMI}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	rounds_remaining = CLIP_SIZE
	firing_mode = firing_mode + 1 % FIRING_MODE.size()
	print(firing_mode)
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
	
	rounds_remaining -= 1
	print(rounds_remaining)
	if rounds_remaining <= 0:
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
	rounds_remaining = CLIP_SIZE

func aim():
	animation_player.play("aim")
	
func un_aim():
	animation_player.play_backwards("aim")


#func _on_timer_timeout() -> void:
	#holster()

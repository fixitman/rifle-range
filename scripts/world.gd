extends Node3D

var targets:Array[Node] = []
@export var distance := 8.0
const TARGET = preload("uid://clbilrw3wi3nw")
@onready var player: CharacterBody3D = $Player
@onready var target_controller: Node = $TargetController


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player.target_hit.connect(target_controller.on_target_hit)
	pass
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
		
		

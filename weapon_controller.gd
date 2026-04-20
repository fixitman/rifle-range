extends Node3D


var current_weapon:Weapon = null
var weapons:Dictionary = {
	'Pistol':null
}
 
const PISTOL = preload("uid://dxftmg4y31kly")
const RIFLE = preload("uid://d3377onhlmsuq")



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	weapons.set('Pistol',PISTOL.instantiate())
	weapons.set('Rifle',RIFLE.instantiate())
	add_child(weapons['Pistol'])
	add_child(weapons['Rifle'])
	current_weapon = weapons['Pistol']
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	pass

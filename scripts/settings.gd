class_name Settings extends Resource

@export var camera_speed: float = 25.0
@export var move_speed:float = 4.5
@export var camera_accel:float = 10.0

const SAVE_PATH: String = "user://range-settings.tres"

signal settings_changed()

	
static func load_or_create() -> Settings:
	var s = ResourceLoader.load(SAVE_PATH) as Settings  
	if !s:
		s = Settings.new()
		s.save()
	return s
	 
func save() ->void:
	settings_changed.emit()
	ResourceSaver.save(self,SAVE_PATH)

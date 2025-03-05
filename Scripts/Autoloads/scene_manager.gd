extends Node

#region On Ready Variables
@onready var main: Node = $"/root/Main"
@onready var main_menu: Control = $"/root/Main/MainMenu"

#endregion


#region Member Variables
const WAVE_SCENE: PackedScene = preload("res://Scenes/wave_scene.tscn")
var current_scene = main_menu
#endregion


#region Public
# Start game from main menu
func start_game() -> void:
	var wave_scene = WAVE_SCENE.instantiate()
	main.remove_child(main_menu)
	main.add_child(wave_scene)
	current_scene = wave_scene
	

# Pause game
func pause_game() -> void:
	pass
	

# Unpause game
func unpause_game() -> void:
	pass
#endregion

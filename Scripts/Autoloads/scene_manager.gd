extends Node

#region On Ready Variables
@onready var main: Node = $"/root/Main"
@onready var main_menu: Control = $"/root/Main/MainMenu"
#endregion


#region Member Variables
const WAVE_SCENE: PackedScene = preload("res://Scenes/wave_scene.tscn")
const ROUND_OVER_SCENE: PackedScene = preload("res://Scenes/round_over_menu.tscn")
var current_scene = main_menu
var current_round: int
#endregion


#region Public
# Start game from main menu
func start_game() -> void:
	var wave_scene = WAVE_SCENE.instantiate()
	main.remove_child(main_menu)
	main.add_child(wave_scene)
	current_scene = wave_scene
	current_round = 1
	

# Return to main menu from pause/game over
func return_to_main() -> void:
	current_scene.queue_free()
	main.add_child(main_menu)
	if get_tree().paused:
		get_tree().paused = false
	current_scene = main_menu
	
	
# Pulls up item selection screen in between rounds
func go_to_item_selection() -> void:
	var round_over_scene = ROUND_OVER_SCENE.instantiate()
	current_scene.queue_free()
	main.add_child(round_over_scene)
	current_scene = round_over_scene
	

# Starts the next round
func go_to_next_round() -> void:
	var wave_scene = WAVE_SCENE.instantiate()
	# Set the wave scene properties here for now
	current_scene.queue_free()
	current_round += 1
	wave_scene.current_round = current_round
	main.add_child(wave_scene)
	current_scene = wave_scene
	
#endregion

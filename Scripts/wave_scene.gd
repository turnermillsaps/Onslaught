extends Node

#region Onready Variables
@onready var round_timer = $RoundTimer
@onready var round_timer_label = $RoundTimerLabel
@onready var castle_wall = $CastleWall
@onready var game_over_gui = $GameOver
@onready var pause_menu = $PauseMenu
#endregion


#region Member Variables
const ENEMY: PackedScene = preload("res://Scenes/enemy.tscn")
@export var round_over: bool = false
@export var game_over: bool = false

@export var max_spawn_frequency: float = 3.0
@export var min_spawn_frequency: float = 2.5
@export var round_duration: int = 30
#endregion


#region Public
func set_rount_timer_wait_time(duration: int) -> void:
	round_duration = duration
#endregion


#region Private
func _ready() -> void:
	_connect_to_wall_death_signal()
	_connect_to_pause_signals()
	_spawn_enemys()
	_update_round_timer_label(str(round_duration))
	_start_round_timer()


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		_pause_game()
	

# Spawns enemies at random intervals between min and max frequency
func _spawn_enemys() -> void:
	while !game_over and !round_over:
		var new_enemy = ENEMY.instantiate()
		await get_tree().create_timer(
			randf_range(min_spawn_frequency, max_spawn_frequency)
		).timeout
		if (!round_over or !game_over):
			add_child(new_enemy)
		else:
			new_enemy.queue_free()
			
			
# Starts the round timer
func _start_round_timer() -> void:
	round_timer.start()
	
	
# Updates the round timer Label
func _update_round_timer_label(time: String) -> void:
	round_timer_label.text = time
	
	
# Connect to the castle wall's health_depleted signal event
func _connect_to_wall_death_signal() -> void:
	castle_wall.connect("health_depleted", _on_wall_health_depleted)
	
	
# Connect to the resume and exit signals of the pause menu
func _connect_to_pause_signals() -> void:
	pause_menu.connect("resume", _on_resume_clicked)
	pause_menu.connect("exit", _on_exit_clicked)
	
	
# Ends the current round and calls scene manager to pull up item selection screen
func _end_round() -> void:
	SceneManager.call_deferred("go_to_item_selection")
	
	
# Pause game
func _pause_game() -> void:
	get_tree().paused = true
	pause_menu.show()
#endregion


#region Public
# Set the round timer property
func set_round_timer(duration: int) -> void:
	pass
#endregion


#region Event Handlers
# Handler for round timer timeout event
func _on_round_timer_timeout() -> void:
	round_duration -= 1
	if round_duration <= 0:
		_end_round()
	else:
		_update_round_timer_label(str(round_duration))
	
	
# Handler for the castle wall's health depleted event
func _on_wall_health_depleted() -> void:
	game_over = true
	get_tree().paused = true
	game_over_gui.show()
	# TODO: For each enemy in the scene, stop them and eventually create an
	# 	animation for them to do
	
	
# Handler for the resume button click event
func _on_resume_clicked() -> void:
	pause_menu.hide()
	get_tree().paused = false
	
	
# Handler for the exit button click event
func _on_exit_clicked() -> void:
	get_tree().quit()
#endregion

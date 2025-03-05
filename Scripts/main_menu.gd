extends Control

#region Event Handlers
# Event handler for start button pressed event
func _on_start_button_pressed() -> void:
	SceneManager.call_deferred("start_game")
	
	
# Event handler for exit button pressed event
func _on_exit_button_pressed() -> void:
	get_tree().quit()
#endregion

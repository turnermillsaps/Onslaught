extends Control

#region Event Handlers
# Handler for next round button pressed event
func _on_next_round_pressed() -> void:
	SceneManager.go_to_next_round()
	
	
# Handler for the main menu button click event
func _on_main_menu_pressed() -> void:
	SceneManager.return_to_main()
#endregion

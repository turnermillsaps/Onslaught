extends Control

#region Signal Handlers
# Handler for Main Menu button pressed event
func _on_main_menu_pressed() -> void:
	SceneManager.call_deferred("return_to_main")
	
	
# Handler for Exit button pressed event
func _on_exit_pressed() -> void:
	get_tree().quit()
#endregion

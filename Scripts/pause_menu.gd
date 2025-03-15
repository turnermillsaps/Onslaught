extends Control

#region Signals
signal resume
signal exit
#endregion


#region Event Handlers
# Handler for the resume button press event
func _on_resume_pressed() -> void:
	resume.emit()
	
	
# Handler for the exit button press event
func _on_exit_pressed() -> void:
	exit.emit()
#endregion

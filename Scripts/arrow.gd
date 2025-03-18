extends Area2D

#region Member Variables
@export var speed: float = 1000.0
@export var damage: float = 12.0
#endregion


#region Private
# Code run for every frame
func _process(delta):
	translate(-transform.y * speed * delta)
#endregion


#region Event Handlers
# Handler for the on body entered signal
func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage)
		queue_free()
	
		
# Handler for on visibility changed event	
func _on_visibility_changed() -> void:
	if visible:
		$DestroyTimer.start.call_deferred()
		
		
# Used for object pooling, called when timer node times out
func end_of_lifetime() -> void:
	print("End of arrow life")
	visible = false
#endregion

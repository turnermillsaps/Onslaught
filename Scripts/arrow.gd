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


#region Public
# Used for object pooling, called when timer node times out
func end_of_lifetime() -> void:
	visible = false
#endregion


#region Event Handlers
func _on_body_entered(body: Node2D) -> void:
	if body.has_method("take_damage"):
		body.take_damage(damage)
		queue_free()
#endregion

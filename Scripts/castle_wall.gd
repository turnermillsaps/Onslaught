extends Area2D

#region Signals
signal health_depleted
#endregion


#region Member Variables
@export var health: float = 100.0
var alive = true
#endregion


#region Public
func take_damage(dmg: float) -> void:
	if alive: # Only take damage if the wall is still up, otherwise ignore any subsequent hit
		health -= dmg
		print("Wall taking damage")
		if health <= 0:
			health_depleted.emit()
			alive = false
#endregion

extends Area2D

#region Member Variables
@export var health: float = 100.0
#endregion


#region Public
func take_damage(dmg: float) -> void:
	health -= dmg
	#TODO: Game ending logic will go here
#endregion

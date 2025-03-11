class_name HitBox
extends Area2D


#region Properties
@export var damage: float
#endregion


#region Construction
# Sets the damage property
func _set_damage(dmg: float) -> void:
	damage = dmg
	
	
# Gets the damage property
func _get_damage() -> float:
	return damage
#endregion


#region Event Handlers
func _on_area_entered(area: Area2D) -> void:
	if area.collision_layer == 1 and area.has_method("take_damage"):
		area.take_damage(damage)
#endregion

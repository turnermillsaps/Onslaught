extends CharacterBody2D

#region Member Variables
@export var speed: float = 10000.0
@export var health: float = 10.0

#endregion


#region OnReady Variables
@onready var wall_detector: RayCast2D = $WallDetector
#endregion


#region Private
func _ready() -> void:
	position = Vector2(randf_range(0, 1080), -30)
	
	
func _physics_process(delta: float) -> void:
	velocity = speed * Vector2(0, 1) * delta
	
	if wall_detector.is_colliding():
		print(wall_detector.get_collider())
	else:
		move_and_slide()
#endregion


#region Public
func take_damage(dmg: float):
	health -= dmg
	if health < 0:
		queue_free()
#endregion


#region Event handlers
#endregion

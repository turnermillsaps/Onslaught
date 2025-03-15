extends CharacterBody2D

#region Member Variables
@export var speed: float = 10000.0
@export var health: float = 10.0
@export var attack_speed: float = 1.0
@export var damage: float = 1.0
var is_attacking: bool = false
#endregion


#region OnReady Variables
@onready var wall_detector: RayCast2D = $WallDetector
@onready var hit_box_shape: CollisionShape2D = $HitBox/CollisionShape2D
@onready var hit_box: Area2D = $HitBox
@onready var attack_timer: Timer = $AttackCooldown
#endregion


#region Private
# On ready 
func _ready() -> void:
	position = Vector2(randf_range(0, 1080), -30)
	hit_box.set_damage(damage)
	
	
# Execute every frame
func _physics_process(delta: float) -> void:
	velocity = speed * Vector2(0, 1) * delta
	
	# TODO: This has the potential to get very messy later on, look at state machines
	if wall_detector.is_colliding() and !is_attacking:
		if (wall_detector.get_collider().collision_layer == 1):
			is_attacking = true
			$AttackCooldown.start()
	elif !wall_detector.is_colliding():
		move_and_slide()
		is_attacking = false
		
		
# Enable hit box and play animation
func _attack() -> void:
	hit_box_shape.disabled = false
	await get_tree().create_timer(0.2).timeout
	hit_box_shape.disabled = true
#endregion


#region Public
# Take damage
func take_damage(dmg: float):
	health -= dmg
	if health < 0:
		queue_free()
#endregion


#region Event handlers
# Attack speed cooldown timeout
func _on_attack_cooldown_timeout() -> void:
	_attack()
#endregion

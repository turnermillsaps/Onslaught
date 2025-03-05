extends CharacterBody2D

#region Export Variables
@export var move_speed : float = 50.0
@export var fire_rate : float = 0.5
#endregion


#region Onready Variables
@onready var arrow_scene = preload("res://Scenes/arrow.tscn")
#endregion


#region Member Variables
var last_fire_time : float
#endregion


#region Private
# Code run every frame
func _process(_delta: float) -> void:
	look_at(get_global_mouse_position())
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		_request_fire_projectile() 
	
	
# Request to fire arrow
func _request_fire_projectile():
	# Early return if attack speed timer is not finished
	if Time.get_unix_time_from_system() - last_fire_time < fire_rate:
		return
	
	# Set last fire time for attack speed
	last_fire_time = Time.get_unix_time_from_system()
	
	# Get the player's mouse direction
	var mouse_dir = position.direction_to(get_global_mouse_position())
	
	# Spawn projectile and set position/rotation
	var arrow = arrow_scene.instantiate()
	arrow.global_position = global_position
	arrow.rotation = mouse_dir.angle() + deg_to_rad(90 + randf_range(-5, 5)) 
	
	# Add arrow instance to scene tree
	get_tree().get_root().add_child(arrow)
#endregion

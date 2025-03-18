extends Node

#region Member Variables
@export var scene_to_spawn: PackedScene
@export var init_amount: int

var pool: Array = []
#endregion


#region Private
func _ready():
	for i in range(init_amount):
		_create_new_node()


func _create_new_node():
	var node = scene_to_spawn.instantiate()
	get_tree().get_root().add_child.call_deferred(node)
	node.visible = false
	pool.append(node)
#endregion


#region Public
func spawn_arrow() -> Node:
	var node = null
	for i in len(pool):
		if pool[i] && pool[i].visible == false:
			node = pool[i]
			break
	
	if node == null:
		node = _create_new_node()
		
	node.show()
	return node
#endregion

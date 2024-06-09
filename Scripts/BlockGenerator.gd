extends Node2D

@export var scene_to_instantiate: PackedScene
@export var number_of_instances: int = 1
@export var spawn_area: Vector2 = Vector2(400, 400)

func _ready():
	generate_instances()
	print("Player ready and instances generated")

func generate_instances():
	for i in range(number_of_instances):
		var instance = scene_to_instantiate.instantiate()
		
		add_child(instance)
		
# Add the instance to the "Block2D" group
		instance.add_to_group("Block2D")
		print("Block2D instance created and added to group: Block2D")

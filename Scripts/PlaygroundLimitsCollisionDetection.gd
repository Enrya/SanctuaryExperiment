extends Area2D

signal BlockTurnedStatic

var processing_body_entered = false

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	print("Ground collision detection ready and signal connected")

func _on_body_entered(body):
	
	#Check if already processing _on_body_entered
	if processing_body_entered:
		#if already processing, exit to prevent infinite recursion return
		return
	
	#Set flag to indicate processing _on_body_entered
	processing_body_entered = true
	
	# Defer reparenting operation to avoid modifying physics state during query
	call_deferred("_reparent_body", body)
	
	print("A body entered the Ground collider: ", body.name)
	
	# Check that the body is in Block2D Group

func _reparent_body(body):
	
	if body.is_in_group("Block2D"):
		print("Body is in Block2D")
		# Reparent the block to the StaticBlocks node
		var static_blocks = get_node("/root/Main/StaticBlocks")
		if static_blocks:
			#Get the global position before reparenting
			var global_position = body.global_position
			#Reparent the block to StaticBlocks
			body.get_parent().remove_child(body)
			static_blocks.add_child(body)
			#Set the global position after reparenting
			body.global_position = global_position
			#A handy signal in case it's useful later
			BlockTurnedStatic.emit()

			print("Block was reparented")
		else:
			print("StatickBlocks node not found")
	else:
		print("Body is not in Block2D group")
	
	processing_body_entered=false

func _on_block_turned_static():
	print ("BlockTurnedStatic signal emitted")

extends Sprite2D


func _process(delta: float) -> void:
	if $"../../characters/player".global_position.y <-274.0:
		self.z_index = 33
	else:
		self.z_index = 1
	

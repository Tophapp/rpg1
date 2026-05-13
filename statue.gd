extends Sprite2D


func _process(delta: float) -> void:
	if $"../../characters/player".position.y <-771.0:
		z_index = 33
	else:
		z_index = 1

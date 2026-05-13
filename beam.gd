extends Node2D



func _process(delta: float) -> void:
	rotation+=1*delta
	var movepos = Vector2(213,-4489)
	if $detector/RayCast2D.is_colliding():
		if $detector/RayCast2D.get_collider().name == "player":
			$"../../characters/player/loadingfade".modulate.r = 200
			$"../../characters/player".transition()
			await get_tree().create_timer(0.50/1.505).timeout
			$"../../characters/player".position = movepos
			$"../../characters/player/Camera2D".global_position = movepos
	if $detector/RayCast2D3.is_colliding():
		if $detector/RayCast2D3.get_collider().name == "player":
			$"../../characters/player/loadingfade".modulate.r = 200
			$"../../characters/player".transition()
			await get_tree().create_timer(0.50/1.505).timeout
			$"../../characters/player".position = movepos
			$"../../characters/player/Camera2D".global_position = movepos
	if $detector/RayCast2D2.is_colliding():
		if $detector/RayCast2D2.get_collider().name == "player":
			$"../../characters/player/loadingfade".modulate.r = 200
			$"../../characters/player".transition()
			await get_tree().create_timer(0.50/1.505).timeout
			$"../../characters/player".position = movepos
			$"../../characters/player/Camera2D".global_position = movepos

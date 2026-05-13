extends Area2D



func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		if $"../../characters/player".desertaccess == false:
			$"../../characters/player".transition()
			await get_tree().create_timer(0.50/1.505).timeout
			$"../../characters/player".global_position = Vector2($"../../characters/player".global_position.x,$"../../characters/player".global_position.y-30)
			$"../../characters/player".popup("You need a cooling device to enter the desert")
		$"../../characters/player".currentarea=name
	

func _ready() -> void:
	connect("body_entered",_on_body_entered)

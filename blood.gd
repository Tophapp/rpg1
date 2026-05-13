extends Area2D



func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		$"..".blood = true
		$"../../characters/player".popup("You have obtained royal blood... I guess...  This is just wrong.")

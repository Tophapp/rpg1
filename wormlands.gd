extends Area2D



func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		if $"../../characters/player".wyrmbell == false:
			$"../../characters/player".currentarea=name

	

func _ready() -> void:
	connect("body_entered",_on_body_entered)

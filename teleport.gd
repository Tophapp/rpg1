extends Area2D

@export var movepos = Vector2(0,0)


	
func _when_body_enters(body: Node2D) -> void:
	if body.name == "player":
			
			$"../../characters/player".transition()
			await get_tree().create_timer(0.50/1.505).timeout
			for child in $"..".get_children():
				if "homepos" in child:
					child.position = child.homepos
			if movepos.x == 0 and movepos.y != 0:
				$"../../characters/player".position.y = movepos.y
				$"../../characters/player/Camera2D".global_position.y = movepos.y
			elif movepos.y == 0 and movepos.x != 0:
				$"../../characters/player".position.x = movepos.x
				$"../../characters/player/Camera2D".global_position.x = movepos.x
			else:
				$"../../characters/player".position = movepos
				$"../../characters/player/Camera2D".global_position = movepos

func _ready() -> void:
	connect("body_entered",_when_body_enters)
	

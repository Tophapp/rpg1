extends Area2D


var done = false
func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		if $"../../characters/player/inside".texture_scale <0.85:
			$"../../characters/player/inside".texture_scale = 0.9
			
			$"../../characters/player".popup("You have obtained the lantern")
			$"../../characters/player/inside/AnimationPlayer".play("lantern")
			$"../../arena".forced.append(get_path())
			done = true


func _process(delta: float) -> void:
	if done == true:
		self.queue_free()
	

extends Area2D

@export var number = 1
var done = false
func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		
		
		$"../../characters/player".popup("You have obtained key number "+str(number))
		$"../../characters/player".keys.append(number)
		$"../../arena".forced.append(get_path())
		done = true


func _process(delta: float) -> void:
	if done == true:
		self.queue_free()
	

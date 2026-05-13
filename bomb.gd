extends Area2D


var done = false
func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
			
			$"../../characters/player".popup("You have obtained DYNAMITE, GASP!!!!  *BOINK* YEAH!!!!  Go blow those rocks to VERY TINY BITS.  Morsels if you will.")
			$"../../characters/player".bomb = true
			$"../../arena".forced.append(get_path())
			done = true


func _process(delta: float) -> void:
	if done == true:
		self.queue_free()
	

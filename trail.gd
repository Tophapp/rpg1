extends AnimatedSprite2D

var lifetimer = 1
func _process(delta: float) -> void:
	lifetimer-=delta*10
	modulate = Color8(255,255,255,100*(lifetimer))
	if lifetimer < 0:
		self.queue_free()
		

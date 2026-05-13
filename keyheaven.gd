extends Area2D

@export var number = 0
var done = false

func _process(delta: float) -> void:
	if done == true:
		self.queue_free()
	
func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		$"..".keys.append(number)
		$"../../characters/player".popup("You have obtained key number "+str(number))
		$"../../arena".forced.append(get_path())
		done = true
		
func _ready() -> void:
	connect("body_entered",_on_body_entered)

extends Area2D

var player_in_range = false
@export var text = ""
var done = false

func _process(delta: float) -> void:
	if done == true:
		self.queue_free()

func _ready() -> void:

	connect("body_entered",_on_interaction_area_body_entered)
	
func _on_interaction_area_body_entered(body):
	if body.name == "player": # Or check for a specific group/type
		$"../../characters/player".popup(text)
		$"../../characters/player".ringofpower=true
		$"../../arena".forced.append(get_path())
		done = true
		
		

extends Area2D

var player_in_range = false
@export var text = ""


func _ready() -> void:
	connect("body_exited",_on_interaction_area_body_exited)
	connect("body_entered",_on_interaction_area_body_entered)
	
func _on_interaction_area_body_entered(body):
	if body.name == "player": # Or check for a specific group/type
		player_in_range = true
		

func _on_interaction_area_body_exited(body):
	if body.name == "player":
		player_in_range = false
		

func _input(event):
	if event.is_action_pressed("done") and player_in_range:
		$"../../characters/player".popup(text)
		$"../../arena".party["archibold"] = "Archibold"
		

extends Area2D

var player_in_range = false
@export var key = 1


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
	if event.is_action_pressed("done") and player_in_range and not key in $"..".keys:
		$"../../characters/player".popup('This Door Reqires Key Number '+str(key)+' To Unlock')
	elif event.is_action_pressed("done") and player_in_range and key in $"..".keys:
		$"../../characters/player".popup("You push the key into the slot, and the door unlocks.")
		for y in range($outline.global_position.y,$outline.shape.size.y+$outline.global_position.y):
			for x in range($outline.global_position.x,$outline.global_position.x+$outline.shape.size.x):
				$"../walls".erase_cell($"../walls".local_to_map(Vector2(x,y)))
			
		

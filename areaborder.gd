extends Area2D

@export var movepos = Vector2(0,0)
signal loadtimer

func _ready() -> void:
	print(get_path())
	ResourceLoader.load_threaded_request("res://" + get_node(self.get_path()).name+".tscn")
	connect("body_entered",_on_body_entered)
	
func loadtimerend():
	loadtimer.emit()

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
			for child in $"..".get_children():
				if child.get_class() == "Area2D":
					child.set_deferred("Monitoring",false)
					child.set_deferred("Monitorable",false)
			
			$"../../characters/player".transition()
			
			await get_tree().create_timer(0.50/1.505).timeout
			$"../../characters/player/inside".visible = false
			$"..".hide()
			$"../../characters/player/Camera2D".position_smoothing_enabled=false
			if movepos.x == 0 and movepos.y != 0:
				$"../../characters/player".position.y = movepos.y
				$"../../characters/player/Camera2D".global_position.y = movepos.y
			elif movepos.y == 0 and movepos.x != 0:
				$"../../characters/player".position.x = movepos.x
				$"../../characters/player/Camera2D".global_position.x = movepos.x
			else:
				$"../../characters/player".position = movepos
				$"../../characters/player/Camera2D".global_position = movepos
			var area =ResourceLoader.load_threaded_get("res://" + get_node(self.get_path()).name+".tscn")
			var areanew = area.instantiate()
			
			#$"../../characters/player/Camera2D".position_smoothing_enabled=true
			#print(areanew.name)
			
			$"../..".call_deferred("add_child", areanew)
			
			$"..".queue_free()
		

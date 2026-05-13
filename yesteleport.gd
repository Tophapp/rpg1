extends Button


signal loadtimer
func loadtimerend():
	loadtimer.emit()
	
func _ready() -> void:
	ResourceLoader.load_threaded_request("res://teleportlobby.tscn")

func _on_button_up() -> void:
			
			for child in $"../../../..".get_child($"../../../..".get_child_count()-1).get_children():
				if child.get_class() == "Area2D":
					child.set_deferred("Monitoring",false)
					child.set_deferred("Monitorable",false)
			
			$"../..".transition()
			
			await get_tree().create_timer(0.50/1.505).timeout
			
			$"../../../..".get_child($"../../../..".get_child_count()-1).hide()
			$"../../Camera2D".position_smoothing_enabled=false

			var area =ResourceLoader.load_threaded_get("res://teleportlobby.tscn")
			var areanew = area.instantiate()
			$"../..".position = Vector2(0,0)
			#$"../../characters/player/Camera2D".position_smoothing_enabled=true
			#print(areanew.name)
			
			$"../../../..".call_deferred("add_child", areanew)
			
			$"../../../..".get_child($"../../../..".get_child_count()-1).queue_free()
			$"..".hide()
			

		

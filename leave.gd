extends Button


@export var movepos = Vector2(0,0)




func _on_button_down() -> void:
			for buttonchild in $"../menu/buttons".get_children():
				buttonchild.queue_free()
			$"../../characters/player/Camera2D".make_current()
	
			$"../../characters/player".moving = true
			$"..".hide()
			var area =load("res://" + get_node(self.get_path()).name+".tscn")
			var areanew = area.instantiate()
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
			#$"../../characters/player/Camera2D".position_smoothing_enabled=true
			#print(areanew.name)
			$"../..".call_deferred("add_child", areanew)

			$"..".queue_free()

extends Area2D

var damage = 1

func _ready():
	monitoring = false
	set_deferred("monitoring", false)
	

func _on_body_entered(body):
	
	if body is TileMapLayer:
		
		var tilemap = body
		var center = tilemap.local_to_map(($"../ray1".global_position+$"../ray1".target_position))
		var radius = 5
		for x in range(center.x - radius, center.x + radius + 1):
			for y in range(center.y - radius, center.y + radius + 1):
				var tile_pos = Vector2i(x, y)
				var tile_data = tilemap.get_cell_tile_data(tile_pos)
				if tile_data and tile_data.get_custom_data("destructible") == true:
					tilemap.erase_cell(tile_pos)
					
					var center2 = tile_pos
					for x2 in range(center2.x - radius*2, center2.x + radius*2 + 1):
						for y2 in range(center2.y - radius*2, center2.y + radius*2 + 1):
							var tile_pos2 = Vector2i(x2, y2)
							var tile_data2 = tilemap.get_cell_tile_data(tile_pos2)
							if tile_data2 and tile_data2.get_custom_data("destructible") == true:
								tilemap.erase_cell(tile_pos2)
			
func attack():
	monitoring = true
	set_deferred("monitoring", true)
	await get_tree().create_timer(0.2).timeout
	monitoring = false

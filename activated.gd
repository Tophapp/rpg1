extends Area2D






func activate():
		for y in range($outline.global_position.y,$outline.shape.size.y+$outline.global_position.y):
			for x in range($outline.global_position.x,$outline.global_position.x+$outline.shape.size.x):
				$"../walls".erase_cell($"../walls".local_to_map(Vector2(x,y)))
			
		

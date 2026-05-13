extends Button


func _on_button_down() -> void:
	$"..".hide()
	for child in $"../../stuff/items".get_children():
		child.queue_free()

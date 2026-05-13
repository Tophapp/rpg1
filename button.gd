extends Button


func _on_button_down() -> void:
	$"../../dialouge".text = "Plainstown"
	for buttonchild in $"../buttons".get_children():
		buttonchild.queue_free()
	$"..".hide()

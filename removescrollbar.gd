extends RichTextLabel

func _process(delta: float) -> void:
	
	if get_child_count()>0:
		get_child(0).visible=false
	get_v_scroll_bar().scale.x = 0
	

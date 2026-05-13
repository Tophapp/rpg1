extends Node2D



func _process(delta) -> void:
	if $"../arena".visible == false:
		$"../characters/player/inside".visible = true
		$Control.visible = true
	else:
		$Control.visible = false
		$"../characters/player/inside".visible = false

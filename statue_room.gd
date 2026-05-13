extends Node2D
var order = []
var correctorder = ["builder","tactician","sage","artist"]
# Called when the node enters the scene tree for the first time.

func _process(delta: float) -> void:
	if order == correctorder:
		$"../key4".visible = true
		$"../key4".monitoring = true
	elif len(order)>=4:
		order= []

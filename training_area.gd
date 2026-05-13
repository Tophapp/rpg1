extends Node2D


func check():
	if not has_node("dummies/forcedencounter"):
		$"../../characters/player".popup("Well done, your key is to my right.")
		$"../key2".monitoring = true
		$"../key2".visible = true

extends Area2D

var active =false
var timeleft = 0
var timerlength = 25
var modulatebasis = self.modulate
var returnpos = Vector2(-3163,-64)
@onready var modulate2 = $"..".modulate
# Called when the node enters the scene tree for the first time.




func _on_interaction_area_body_entered(body):
	if body.name == "player":
		active = true
		
		$"../../../characters/player".timedpuzzle(timerlength,self.get_path())
		if has_node("../../forcedencounter"):
			$"../../forcedencounter".monitoring = true
																																																																																																																																																																																																																												 
		$"../finish".monitoring = true
	
	
func _process(delta: float) -> void:
	if active:
		if has_node("../../forcedencounter"):
			$"../../forcedencounter".monitoring = true
		$"../finish".monitoring = true
		$AnimatedSprite2D.frame = 1
		
		if timeleft < timerlength:
			timeleft+=delta
			
			
			$"..".modulate = modulate2.lerp(Color(1,0.41,0.10,1),timeleft/timerlength)
		
	else:
		if has_node("../../forcedencounter"):
			$"../../forcedencounter".monitoring = false
		$"../finish".monitoring = false
		$"..".modulate = modulate2
		$AnimatedSprite2D.frame = 0
		timeleft = 0
		self.modulate = modulatebasis

func _on_finish_body_entered(body: Node2D) -> void:
	if body.name == "player":
		active = false
		$"../../Pixil-frame-0(97)/inside".show()
		$"../../Pixil-frame-0(97)".texture = load("res://sprites/pixil-frame-0 (98).png")
		$"../../key1".monitoring = true
		$"../../key1".visible = true

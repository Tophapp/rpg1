extends RigidBody2D
var homepos = Vector2(0,0)
@export var color = ""
func _when_body_exits(body: Node2D) -> void:
	if body.name=="player":
		self.linear_velocity = Vector2.ZERO
		self.angular_velocity = 0
	
	if body.name =="player":
		$"../../characters/player".speed = 65
		
func _when_body_enters(body: Node2D) -> void:
	if body.name =="player":
		$"../../characters/player".speed = 30

func _ready() -> void:
	homepos = position
	$Area2D.connect("body_exited",_when_body_exits)
	$Area2D2.connect("body_entered",_when_body_enters)
	$Area2D2.connect("body_exited",_when_body_exits)
	
	

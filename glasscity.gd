extends Node2D

var trials = {"first":false,"second":false,"third":false}
var keys = {"wits":false,"strength":false}
var blood = false
var popupcomplete = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	keys = $"../characters/player".glasskeys

@export var moveposswitch1 = Vector2(1089,-1975)
@export var moveposswitch2 = Vector2(0,-2536)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$"../characters/player".glasskeys = keys
	if trials["first"] and trials["second"] and popupcomplete==false:
		$"../characters/player".popup("The Final Trial, against the 100 year reigning champion himself, awaits you upon the center pedestal")
		$forcedencounter3/CollisionPolygon2D.disabled=false
		popupcomplete=true
		


func _on_movabletilebutton_body_entered(body: Node2D) -> void:
	keys["wits"] = true
	$"../characters/player".popup("You have obtained the Key of Wits!")


func _on_switch_1_body_entered(body: Node2D) -> void:
	if body.name == "player":
		$"../characters/player".transition()
		await get_tree().create_timer(0.50/1.505).timeout
		$"../characters/player".position = moveposswitch1
		$"../characters/player/Camera2D".global_position = moveposswitch1

func _on_switch_2_body_entered(body: Node2D) -> void:
	if body.name == "player":
		$"../characters/player".transition()
		await get_tree().create_timer(0.50/1.505).timeout
		$"../characters/player".position = moveposswitch2
		$"../characters/player/Camera2D".global_position = moveposswitch2

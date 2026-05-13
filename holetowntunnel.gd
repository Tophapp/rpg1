extends Node2D

@export var caveinmovepos = Vector2(5043,2560)
@export var caveinmovepos2 = Vector2(-559,420)
var idols = [false,false,false]
var idolsdone = false
var cavein = false

func _ready():
	$"floors/3/cavein".position = Vector2(1000,1000)

func _process(delta) -> void:
	if idols == [true,true,true] and idolsdone != true:
		$unlockabledoor1.activate()
		idolsdone = true
	if $"../arena".visible == false:
		$"../characters/player/inside".visible = true
		$Control.visible = true
	else:
		$Control.visible = false
		$"../characters/player/inside".visible = false


func _on_gateteleporter_body_entered(body: Node2D) -> void:
	if body.name == "player":
		$"../characters/player".transition()
		await get_tree().create_timer(0.50/1.505).timeout
		$"../characters/player".position = caveinmovepos
		
		$"../characters/player/Camera2D".global_position = caveinmovepos

func _on_cavein_body_entered(body: Node2D) -> void:
	if body.name == "player":
		if $"../characters/player".bomb == false and cavein != true:
			cavein = true
			$"../characters/player".moving = false
			$cavein/GPUParticles2D.emitting=true
			await get_tree().create_timer(4.5).timeout
			$"../characters/player/rockonhead".emitting = true
			await get_tree().create_timer(0.89).timeout
			$"../characters/player".transition2()
			await get_tree().create_timer(0.3/1.505).timeout
			$"../characters/player".moving = true
			$"floors/3/cavein".position = Vector2.ZERO
			$cavein/GPUParticles2D.hide()

func _on_gateteleporter_2_body_entered(body: Node2D) -> void:
	if body.name == "player":
		$"../characters/player".transition()
		await get_tree().create_timer(0.50/1.505).timeout
		$"../characters/player".position = caveinmovepos2
		
		$"../characters/player/Camera2D".global_position = caveinmovepos2

func _on_movabletilebutton_body_entered(body: Node2D) -> void:
	if body.color == 1:
		idols[0] = true
	else:
		idols[0] = false

func _on_movabletilebutton_2_body_entered(body: Node2D) -> void:
	if body.color == 1:
		idols[1] = true
	else:
		idols[1] = false

func _on_movabletilebutton_3_body_entered(body: Node2D) -> void:
	if body.color == 1:
		idols[2] = true
	else:
		idols[2] = false

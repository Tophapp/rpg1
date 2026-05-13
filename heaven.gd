extends Node2D


var keys = []
var order = []
var moveposheavendemos = Vector2(875,3265)
var pattern = {1:false,2:false,3:false}
var moveposheavenmain = Vector2(355,-792)
var key4obtained = false
var correctorder = ["create","down","right","up"]
var playeronstage = false
var last7inputs = ["up","up","up","up","up","up","up"]
var stagepuzzlepath = ["up","down","down","left","right","right","right"]
func _ready() -> void:
	keys = $"../characters/player".heavenkeys
	#$invisiblecollisions.modulate = Color8(255,255,255,0)

var key5obtained = false
func _process(delta: float) -> void:
	if pattern == {1:true,2:true,3:true} and key5obtained == false:
		$"../characters/player".popup("The key appears on the pedestal")
		$"key5".visible = true
		$"key5".monitoring = true
		key5obtained = true
	$"../characters/player".heavenkeys = keys
	if $gateteleporter/AnimatedSprite2D.frame == 7:
		$"../characters/player".z_index = -100
	if order == correctorder and key4obtained == false:
		$"../characters/player".popup("The key appears on the pedestal")
		$"key4".visible = true
		$"key4".monitoring = true
		key4obtained = true
	elif len(order)>=4:
		order= []
	if playeronstage:
		if Input.is_action_just_released("up"):
			last7inputs.pop_front()
			last7inputs.append("up")
		elif Input.is_action_just_released("down"):
			last7inputs.pop_front()
			last7inputs.append("down")
		elif Input.is_action_just_released("left"):
			last7inputs.pop_front()
			last7inputs.append("left")
		elif Input.is_action_just_released("right"):
			last7inputs.pop_front()
			last7inputs.append("right")
		if last7inputs==stagepuzzlepath and not 7 in keys:
			keys.append(7)
			$"../characters/player".popup("You have obtained the 7th key!")
			
		
func _on_stagepuzzle_body_entered(body: Node2D) -> void:
	if body.name == "player":
		playeronstage = true
		
func _on_stagepuzzle_body_exited(body: Node2D) -> void:
	if body.name == "player":
		playeronstage = false

func _on_gateteleporter_body_entered(body: Node2D) -> void:
	if body.name == "player":
		$"../characters/player".moving = false
		$gateteleporter/AnimatedSprite2D.play()
	
func _on_animated_sprite_2d_animation_finished() -> void:
	$gateteleporter/AnimatedSprite2D.hide()
	
	$"../characters/player".transition()
	await get_tree().create_timer(0.50/1.505).timeout
	$"../characters/player".position = moveposheavenmain
	$"../characters/player/Camera2D".global_position = moveposheavenmain
	$"../characters/player".z_index = 0


func _on_area_2d_body_entered(body: Node2D) -> void:
	body.queue_free()
	$"buildable statue".frame+=1
	if $"buildable statue".frame == 3:
		$"../characters/player".popup("A key falls out")
		$"key6".monitoring = true
		$"key6".show()
	
	

func _on_movabletilebutton1_body_entered(body: Node2D) -> void:
	pattern[1] = true
func _on_movabletilebutton_body_exited(body: Node2D) -> void:
	pattern[1] = false
func _on_movabletilebutton_2_body_entered(body: Node2D) -> void:
	pattern[2] = true
func _on_movabletilebutton_2_body_exited(body: Node2D) -> void:
	pattern[2] = false
func _on_movabletilebutton_3_body_entered(body: Node2D) -> void:
	pattern[3] = true
func _on_movabletilebutton_3_body_exited(body: Node2D) -> void:
	pattern[3] = false

func _on_gateteleporter_2_body_entered(body: Node2D) -> void:
	if body.name == "player":
		$"../characters/player".moving = false
		$gateteleporter2/AnimatedSprite2Dteleporter2.play()
func _on_animated_sprite_2_dteleporter_2_animation_finished() -> void:
	$gateteleporter/AnimatedSprite2D.hide()
	
	$"../characters/player".transition()
	await get_tree().create_timer(0.50/1.505).timeout
	$"../characters/player".position =moveposheavendemos
	$"../characters/player/Camera2D".global_position = moveposheavendemos
	$"../characters/player".z_index = 0

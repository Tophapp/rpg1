extends Node2D

var currentcolor = "red"
var coloredblocks = {"red":false,"green":false,"blue":false,"purple":false}

func _ready() -> void:
	currentcolor = ["red","blue","yellow","green"][randi_range(0,3)]
	var colorriddles = ["This stone, pulled from the ashes of hell, will open your way unto the further conquest.","This stone, ripped from the torrential forces alluring to the depths, will open your way unto the further conquest.","This stone, struck from a fleeting creation, will open your way unto the further conquest.","This stone, pulled from the binds of self creation, will open your way unto the further conquest."]
	$interact1.text = colorriddles[["red","blue","yellow","green"].find(currentcolor)]
	
func _process(delta) -> void:
	$spawn.modulate = Color8(1,1,1,1)
	if $"../arena".visible == false:
		$"../characters/player/inside".visible = true
		$Control.visible = true
	else:
		$Control.visible = false
		$"../characters/player/inside".visible = false


func _on_movabletilebutton_body_entered(body: Node2D) -> void:
	var tile_pos = $ground3.local_to_map(Vector2(-67,11))
	var tile_data = $ground3.get_cell_tile_data(tile_pos)
	$ground3.erase_cell(tile_pos)
	$"../characters/player".popup("You hear a click")


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name=="player":
		$movabletile.linear_velocity = Vector2.ZERO
		$movabletile.angular_velocity = 0
	
	if body.name =="player":
		$"../characters/player".speed = 100

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name =="player":
		$"../characters/player".speed = 50

func _on_movabletilebutton_2_body_entered(body: Node2D) -> void:
	var tile_pos = $ground3.local_to_map(Vector2(14,-941))
	$ground3.erase_cell(tile_pos)
	tile_pos = $ground3.local_to_map(Vector2(-17,-941))
	$ground3.erase_cell(tile_pos)
	$"../characters/player".popup("You hear a click")


func _on_area_2d_body_exited2(body: Node2D) -> void:
	pass # Replace with function body.


func _on_movabletilebutton_3_body_entered(body: Node2D) -> void:
	if body.color == currentcolor:
		var tile_pos = $ground3.local_to_map(Vector2(77,-1706))
		$ground3.erase_cell(tile_pos)
		tile_pos = $ground3.local_to_map(Vector2(47,-1706))
		$ground3.erase_cell(tile_pos)
		tile_pos = $ground3.local_to_map(Vector2(111,-1706))
		$ground3.erase_cell(tile_pos)
		$movabletilebutton3.queue_free()
		$"../characters/player".popup("You hear a click")
	else:
			var movepos = Vector2(-967,-861)
			$"../characters/player".transition()
			await get_tree().create_timer(0.50/1.505).timeout
			for child in $"..".get_children():
				if "homepos" in child:
					child.position = child.homepos
			$"../characters/player".position.y = movepos.y
			$"../characters/player/Camera2D".global_position.y = movepos.y
			$"../characters/player".position.x = movepos.x
			$"../characters/player/Camera2D".global_position.x = movepos.x
			currentcolor = ["red","blue","yellow","green"][randi_range(0,3)]
			var colorriddles = ["This stone, pulled from the ashes of hell, will open your way unto further conquest.","This stone, struck from the torrential forces alluring to the depths, will open your way unto further conquest.","This stone, struck from a fleeting creation, will open your way unto further conquest.","This stone, pulled from the binds of self creation, will open your way unto further conquest."]
			$interact1.text = colorriddles[["red","blue","yellow","green"].find(currentcolor)]


func _on_movabletilebutton_4_body_entered(body: Node2D) -> void:
	if body.color == "red":
		coloredblocks["red"]=true
	var colorscorrect = 0
	for color in coloredblocks.keys():
		if coloredblocks[color] == true:
			colorscorrect+=1
	if colorscorrect >= 4:
		$ground3.erase_cell($ground3.local_to_map(Vector2(208,-1683)))
		$ground3.erase_cell($ground3.local_to_map(Vector2(208,-1667)))
		$ground3.erase_cell($ground3.local_to_map(Vector2(208,-1651)))
		$ground3.erase_cell($ground3.local_to_map(Vector2(208,-1635)))
		$ground3.erase_cell($ground3.local_to_map(Vector2(208,-1619)))
		$ground3.erase_cell($ground3.local_to_map(Vector2(208,-1603)))
		$ground3.erase_cell($ground3.local_to_map(Vector2(208,-1587)))
		$"../characters/player".popup("You hear a click down the hall")
func _on_movabletilebutton_4_body_exited(body: Node2D) -> void:
	if body.color == "red":
		coloredblocks["red"]=false
func _on_movabletilebutton_5_body_entered(body: Node2D) -> void:
	if body.color == "green":
		coloredblocks["green"]=true
	var colorscorrect = 0
	for color in coloredblocks.keys():
		if coloredblocks[color] == true:
			colorscorrect+=1
	if colorscorrect >= 4:
		$ground3.erase_cell($ground3.local_to_map(Vector2(208,-1683)))
		$ground3.erase_cell($ground3.local_to_map(Vector2(208,-1667)))
		$ground3.erase_cell($ground3.local_to_map(Vector2(208,-1651)))
		$ground3.erase_cell($ground3.local_to_map(Vector2(208,-1635)))
		$ground3.erase_cell($ground3.local_to_map(Vector2(208,-1619)))
		$ground3.erase_cell($ground3.local_to_map(Vector2(208,-1603)))
		$ground3.erase_cell($ground3.local_to_map(Vector2(208,-1587)))
		$"../characters/player".popup("You hear a click down the hall")
func _on_movabletilebutton_5_body_exited(body: Node2D) -> void:
	if body.color == "green":
		coloredblocks["green"]=false
func _on_movabletilebutton_6_body_entered(body: Node2D) -> void:
	if body.color == "blue":
		coloredblocks["blue"]=true
	var colorscorrect = 0
	for color in coloredblocks.keys():
		if coloredblocks[color] == true:
			colorscorrect+=1
	if colorscorrect >= 4:
		$ground3.erase_cell($ground3.local_to_map(Vector2(208,-1683)))
		$ground3.erase_cell($ground3.local_to_map(Vector2(208,-1667)))
		$ground3.erase_cell($ground3.local_to_map(Vector2(208,-1651)))
		$ground3.erase_cell($ground3.local_to_map(Vector2(208,-1635)))
		$ground3.erase_cell($ground3.local_to_map(Vector2(208,-1619)))
		$ground3.erase_cell($ground3.local_to_map(Vector2(208,-1603)))
		$ground3.erase_cell($ground3.local_to_map(Vector2(208,-1587)))
		$"../characters/player".popup("You hear a click down the hall")
func _on_movabletilebutton_6_body_exited(body: Node2D) -> void:
	if body.color == "blue":
		coloredblocks["blue"]=false
func _on_movabletilebutton_7_body_entered(body: Node2D) -> void:
	if body.color == "purple":
		coloredblocks["purple"]=true
	var colorscorrect = 0
	for color in coloredblocks.keys():
		if coloredblocks[color] == true:
			colorscorrect+=1
	if colorscorrect >= 4:
		$ground3.erase_cell($ground3.local_to_map(Vector2(208,-1683)))
		$ground3.erase_cell($ground3.local_to_map(Vector2(208,-1667)))
		$ground3.erase_cell($ground3.local_to_map(Vector2(208,-1651)))
		$ground3.erase_cell($ground3.local_to_map(Vector2(208,-1635)))
		$ground3.erase_cell($ground3.local_to_map(Vector2(208,-1619)))
		$ground3.erase_cell($ground3.local_to_map(Vector2(208,-1603)))
		$ground3.erase_cell($ground3.local_to_map(Vector2(208,-1587)))
		$"../characters/player".popup("You hear a click down the hall")
func _on_movabletilebutton_7_body_exited(body: Node2D) -> void:
	if body.color == "purple":
		coloredblocks["purple"]=false


func _on_movabletilebutton_8_body_entered(body: Node2D) -> void:
	if body.color == "red":
		$ground3.set_cell($ground3.local_to_map(Vector2i(-33,-4753)),6,Vector2i(6,4))
		$ground7/LightOccluder2D4.visible=true
		$ground7/obstruction2/CollisionPolygon2D4.call_deferred("set_deferred", "disabled", false)
		
func _on_movabletilebutton_9_body_entered(body: Node2D) -> void:
	if body.color == "blue":
		$ground3.set_cell($ground3.local_to_map(Vector2i(-82,-4653)),6,Vector2i(6,4))
		$ground7/LightOccluder2D5.visible=true
		$ground7/obstruction2/CollisionPolygon2D5.call_deferred("set_deferred", "disabled", false)

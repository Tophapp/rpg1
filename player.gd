extends CharacterBody2D

var keys = []
var heavenkeys = []
var glasskeys = {}
var wyrmbell = false
var ferryaccess = false
var desertaccess = false
var ringofpower = false
var target_position = position
var tile_size = 32
var moving = true
var beatengame = false
var dashcooldown = 1
var enemytypes = []
var bomb = false
var movingin =Vector2(0,0)
var speed = 65
var framescount = 0
var puzzlepath = "madeupathofcool"
var currentarea ="plains"
var spawning ={ 
	"plains":["claygolem","claysoldier","clayblob","clayspider"]
	
	,"marsh":["woodgolem","woodbat","woodspider","claygolem","clayblob","claybat"]
	,"farmlands":["woodspider","clayspider","woodbat","claybat","claysoldier","clayblob"]
	,"mountains":["claygolem","woodgolem","metalblob","claybat","woodbat","claygolem"]
	,"heaven":["angel","nightmare","lostsoul","plasticminiboss","angel","plasticbat","angel","nightmare","lostsoul","plasticgolem","plasticgolem","plasticsoldier"]
	,"hell":["demon","nightmare","lostsoul","skeleton","metalblob","metalbat","metalgolem","metalminiboss","demon","demon","lostsoul","skeleton","metalblob","metalbat","metalspider","plasticblob"]
	,"rocklands":["woodminiboss","woodspider","woodbat","woodgolem","metalblob","claygolem","woodsoldier","woodbat","woodgolem","metalblob","clayblob"]
	,"desert":["clayminiboss","woodminiboss","metalsoldier","woodgolem","claygolem","woodbat"]
	,"wormlands":["wyrm","elderwyrm"]
	,"glasscity":["clayminiboss","clayminiboss","clayminiboss","clayminiboss","metalsoldier","claysoldier","woodsoldier","plasticsoldier","metalminiboss","woodminiboss"]
	,"lighthouse":["clayspider","woodspider","claybat"]
	,"crystalcaves":["metalgolem","metalspider","skeleton","woodspider","metalbat","skeleton","skeleton","woodbat"]
	,"fortress":["demon"]
}
var levels ={
	"plains":[1,10]
	,"marsh":[5,15]
	,"farmlands":[1,15]
	,"mountains":[10,20]
	,"heaven":[60,95]
	,"hell":[35,55]
	,"rocklands":[15,30]
	,"desert":[20,40]
	,"wormlands":[101,200]
	,"glasscity":[50,70]
	,"lighthouse":[5,15]
	,"crystalcaves":[25,35]
	,"fortress":[40,60]
}
var inputs = {"right": Vector2(1,0),
			"left": Vector2(-1,0),
			"up": Vector2(0,-1),
			"down": Vector2(0,1)}

var frames = {"right": 0,
			"left": 1,
			"up": 3,
			"down": 2}
			

func loadJSON(file_path: String):
	var file_access = FileAccess.open(file_path, FileAccess.READ)

	if file_access:
		var content = file_access.get_as_text()
		file_access.close()
		var parse_result = JSON.parse_string(content)
		enemytypes = parse_result
		

var startposition = position
func move(dir,delta):
	if delta < 1:
		$ray1.target_position = inputs[dir]*10
	else:
		$ray1.target_position = inputs[dir]*delta*speed
	$ray1.force_raycast_update()
	if !$ray1.is_colliding():
		#position += (inputs[dir] * tile_size)
		position += inputs[dir]*delta*speed
	
	if $ray2.is_colliding():
		if randi_range(1,500) == 1:
			battlestart()
	if not $ray3.is_colliding():
		$top/AnimatedSprite2D.z_index == 32
		$top/AnimatedSprite2D.show()
	else:
		$top/AnimatedSprite2D.z_index == 2
		if $ray2.is_colliding():
			$top/AnimatedSprite2D.hide()

func battlestart():
	var enemycount = randi_range(1,4)
	$"../../arena".enemies = {}
	$"../../arena".enemiesstats = {}
	$"../../arena".enemiesstatus = {}
	$"../../arena".enemiesstatslvl = {}
	$"../../arena".enemyhp = {}
	for creature in enemycount:
		var level = randi_range(levels[currentarea][0],levels[currentarea][1])
		var generatedenemy = [spawning[currentarea][randi_range(0,len(spawning[currentarea])-1)],randi()]
		$"../../arena".enemies[generatedenemy] = enemytypes[generatedenemy[0]]["name"]
		var hp1 = enemytypes[generatedenemy[0]]["hp"]+randi_range(-5,5)+round(level/2)
		$"../../arena".enemyhp[generatedenemy]=hp1
		$"../../arena".enemiesstats[generatedenemy] = hp1
		$"../../arena".enemiesstatus[generatedenemy] = []
		$"../../arena".enemiesstatslvl[generatedenemy] = level
	$"../../arena".start()
	
	
func timedpuzzle(time,path):
	$timedpuzzletimer.wait_time = time
	puzzlepath=path
	$timedpuzzletimer.start()
	
func _ready():
	
	loadJSON("res://tables/creaturestats.json")
	if not OS.is_debug_build():
		$loadingfade/AnimationPlayer.speed_scale = 0.1
	#speed = 1000
	moving = false
	self.call_deferred("transitionend","ooogleboogle")
	
	
func transition():
	moving = false
	$loadingfade/AnimationPlayer.play("fadetoblack")

	
func transitionend(namethatalsoisuselessandbadandsad):
	$loadingfade.modulate.r = 0
	if namethatalsoisuselessandbadandsad != "fadeback":
		$loadingfade/AnimationPlayer.play("fadeback")
		
	elif namethatalsoisuselessandbadandsad != "ooogleboogle":
		$loadingfade/AnimationPlayer.speed_scale = 1.50
		moving = true

func transition2():
	moving = false
	
	$loadingfade/AnimationPlayer2.play("fadetoblack_2")

	

func _process(delta: float) -> void:
	framescount+=1
	dashcooldown-=delta
	if dashcooldown < 0.83:
		speed = 100
	elif dashcooldown < 0.80:
		speed = 85
	elif dashcooldown < 0.77:
		speed = 65
	elif framescount % 10 == 0:
		var newtrail = load("res://trail.tscn").instantiate()
		$"..".add_child(newtrail)
		newtrail.frame=$top/AnimatedSprite2D.frame
		newtrail.global_position = self.global_position
	#$inventory.offset = Vector2(-230+(self.global_position.x*$Camera2D.zoom.x),-127+(self.global_position.y*$Camera2D.zoom.y))
	if get_tree().get_root().has_node(puzzlepath):
		$puzzletimerdisplay.show()
		$puzzletimerdisplay/display.text = str(round($timedpuzzletimer.time_left))
		if get_tree().get_root().get_node(puzzlepath).active == false:
			$timedpuzzletimer.stop()
			$puzzletimerdisplay.hide()
			
	if moving:
		for dir in inputs.keys():
				if Input.is_action_pressed(dir):
					move(dir,delta)
					$top/AnimatedSprite2D.frame = frames[dir]
					$bottom/AnimatedSprite2D2.frame = frames[dir]
					movingin = dir
					break
					
	if Input.is_action_pressed("pull") and ringofpower:
		for blockpotential in $"../..".get_child($"../..".get_child_count()-1).get_children():
			if blockpotential is RigidBody2D and (holding == blockpotential.name or holding == ""):
				if blockpotential.global_position.distance_to(self.global_position) < 50:
					blockpotential.global_position = Vector2(self.global_position.x,self.global_position.y-20)
					holding =blockpotential.name
					
	elif Input.is_action_just_released("pull"):
		holding = ""
			
				
var left_held3 = false
var left_held = false
var left_held2 = false
var holding = ""
func _input(event):
	if event.is_action_pressed("destroy"):
		if not left_held3:
			left_held3 = true
			$break.attack()
	elif event.is_action_released("destroy"):
			left_held3 = false
	if event.is_action_pressed("inventory"):
		if not left_held2:
			left_held2 = true
			if $inventory.visible == false:
						$inventory.show()
						moving = false
			else:
						$inventory.hide()
						moving = true
	elif event.is_action_released("inventory"):
			left_held2 = false
	
	
					
		
	if event.is_action_pressed("done"):
		if not left_held:
			left_held = true
			$"../../arena".doneemit()
	elif event.is_action_released("done"):
			left_held = false
	if event.is_action_pressed("dash") and dashcooldown < 0:
		dashcooldown = 1
		speed*=4
		var newtrail = load("res://trail.tscn").instantiate()
		$"..".add_child(newtrail)
		newtrail.frame=$top/AnimatedSprite2D.frame
		newtrail.global_position = self.global_position
	if event.is_action_pressed("teleport") and beatengame == true:
			$"teleportmenu".show()
		
				

func popup(notice):
	$popup/RichTextLabel.text = notice
	$"../../arena/popup/RichTextLabel".text = notice
	if $"../../arena".battling == false:
		$popup.show()
	else:
		$"../../arena/popup".show()
	moving = false

func endtimedpuzzle():
	if get_tree().get_root().has_node(puzzlepath):
		$puzzletimerdisplay.hide()
		get_tree().get_root().get_node(puzzlepath).active = false
	
func _on_timedpuzzletimer_timeout() -> void:
	if get_tree().get_root().has_node(puzzlepath):
		position = get_tree().get_root().get_node(puzzlepath).returnpos
		$puzzletimerdisplay.hide()
		get_tree().get_root().get_node(puzzlepath).active = false
		$"../../arena".end()


func tansitionend2(anim_name: StringName) -> void:
	$loadingfade.modulate.r = 0
	if anim_name != "fadeback_2":
		await get_tree().create_timer(2).timeout
		$loadingfade/AnimationPlayer2.play("fadeback_2")

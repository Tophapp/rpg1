extends Node2D

var pllevel = {"player":1,"edward":1,"mallouk":1,"gallous":1,"smith":1,"archibold":1}
var plhp = {"player":2000,"edward":2000,"mallouk":2000,"gallous":2000,"smith":2000,"archibold":2000}
var plmaxhp = {"player":25,"edward":25,"mallouk":25,"gallous":25,"smith":25,"archibold":25}
var plmaxhpbse = {"player":25,"edward":25.02,"mallouk":25.05,"gallous":25,"smith":24.5,"archibold":25}
var plspeed = {"player":5,"edward":5,"mallouk":5,"gallous":5,"smith":5,"archibold":5}
var plattack = {"player":5,"edward":7,"mallouk":6,"gallous":4,"smith":3,"archibold":5}
var pldefense = {"player":5,"edward":5,"mallouk":5,"gallous":5,"smith":4,"archibold":5}
var plmagic = {"player":5,"edward":0,"mallouk":0,"gallous":5,"smith":4,"archibold":5}

var animationloopspeed = 0.7
var currentsprite = [str("res://sprites/placeholderrpg1.png"),str("res://sprites/placeholderrpg1.png"),str("res://sprites/placeholderrpg1.png"),str("res://sprites/placeholderrpg1.png"),str("res://sprites/placeholderrpg1.png"),str("res://sprites/placeholderrpg1.png")]
var loopcount2 = [0,0,0,0,0,0]

var plxp = {"player":0,"edward":0,"mallouk":0,"gallous":0,"smith":0,"archibold":0}
var plstatus = {"player":[],"edward":[],"mallouk":[],"gallous":[],"smith":[],"archibold":[]}
var plstatus2 = {"player":[],"edward":[],"mallouk":[],"gallous":[],"smith":[],"archibold":[]}
var plbuffs = {"player":{"atk":1,"def":1,"mgc":1,"hp":1},"edward":{"atk":1,"def":1,"mgc":1,"hp":1},"mallouk":{"atk":1,"def":1,"mgc":1,"hp":1},"gallous":{"atk":1,"def":1,"mgc":1,"hp":1},"smith":{"atk":1,"def":1,"mgc":1,"hp":1},"archibold":{"atk":1,"def":1,"mgc":1,"hp":1}}
var plequipment = {"player":{},"edward":{},"mallouk":{},"gallous":{},"smith":{},"archibold":{}}
var plspells = {"player":{"Magic Missile":0},"edward":{},"mallouk":{},"gallous":{"Magic Missile":0},"smith":{"Magic Missile":0},"archibold":{"Magic Missile":0}}

var forced = []
var reward = {}
var endatend = "nothing"
var lastsavepos = [Vector2(0,0),"yourhouse"]
var forcedbool = null
var inventory = {}#"name":{"hp":0,"effects":[],"buffs":[],"price":0,"special":[],"target":"You","desc":"","amount":1}
var equipmentinventory = {}#"Item":[1,"atk","atk","def"]
var playerclass = "sorcerer"
var party = {"player":"You"}
var stack = []
var turn = -1
var gold = 0
var damagegoal = 0
var stolen = 0
@onready var enemyhp = {"bat":10,"blob":20,"golem":30,"soldier":15,"spider":5,"demon":100,"angel":200,"porcelainGuard":100,"levish":60,"steelStriker":140,"plasticmenace":250}
@onready var enemyeffcts = {"bat":10,"blob":20,"golem":30,"soldier":15,"spider":5,"demon":100,"angel":200,"porcelainGuard":100,"levish":60,"steelStriker":140,"plasticmenace":250}
@onready var enemydmg = {"bat":5,"blob":6,"golem":8,"soldier":9,"spider":14,"demon":48,"angel":79,"porcelainGuard":25,"levish":16,"steelStriker":50,"plasticmenace":110}
@onready var enemysprites = {"claygolem":{"attack":[str("res://sprites/golem-grayscale-pixilart (2).png")],"hurt":[str("res://sprites/golem-grayscale-pixilart (1).png")],"idle":[str("res://sprites/pixil-frame-0 - 2026-04-12T202524.064.png"),str("res://sprites/golem-grayscale-pixilart.png")]}
,"lighthouseguardian":{"attack":[str("res://sprites/lighthouse-boss-idle-3-pixilart.png"),str("res://sprites/lighthouse-boss-aoe-attk-1-pixilart.png")],"hurt":[str("res://sprites/golem-grayscale-pixilart (2).png")],"idle":[str("res://sprites/lighthouse-boss-idle-1-pixilart (1).png"),str("res://sprites/lighthouse-boss-idle-1-pixilart (2).png"),str("res://sprites/lighthouse-boss-idle-2-pixilart.png"),str("res://sprites/lighthouse-boss-idle-1-pixilart (3).png"),str("res://sprites/lighthouse-boss-idle-1-pixilart (4).png")]}
,"":{"attack":[str("")],"hurt":[str("")],"idle":[str(""),str("")]}
}
@onready var enemycolor = {"clayblob":Color8(157,130,109),"claygolem":Color8(157,130,109),"lighthouseguardian":Color8(255,255,255)}
var enemies = {["golem","clay",1]:"Clay Golem",["golem","clay",2]:"Clay Golem"}
var enemiesstats = {["golem","clay",1]:50,["golem","clay",2]:50}
var enemiesstatus = {["golem","clay",1]:[],["golem","clay",2]:[]}
var enemiesstatslvl = {["golem","clay",1]:5,["golem","clay",2]:5}
var casting = false
var enemytypes ={}
var spellslotindex = 0
var battling = false

signal fight
signal done
signal target
signal item
signal run
signal magic
signal begin
signal select
signal sec1
var boss = false
var targetindex = null
var spells = {}
var spellname = null
signal chooseitem
var item5 = false
var counters = []


				
func _ready():
	loadJSON("res://tables/spells.json")
	loadJSON2("res://tables/creaturestats.json")
	for dmgvalue in enemytypes.keys():
		enemydmg[dmgvalue] = enemytypes[dmgvalue]["dmg"]
	for effctsvalue in enemytypes.keys():
		enemyeffcts[effctsvalue] = enemytypes[effctsvalue]["efcts"]
	
	
func wipeout():
	battling = false
	$"../characters/player".endtimedpuzzle()
	for buttonchild in $"menu/the smith/buttons".get_children():
		buttonchild.queue_free()
	for buttonchild in $"menu/archibold/buttons".get_children():
		buttonchild.queue_free()
	for buttonchild in $"menu/gallous/buttons".get_children():
		buttonchild.queue_free()
	for buttonchild in $"menu/you/buttons".get_children():
		buttonchild.queue_free()
	$info.text = "You have been defeated."
	for player in party.keys():
		plhp[player] = plmaxhp[player]
	await done
	gold-=stolen
	pray()
	end()

func loadJSON(file_path: String):
	var file_access = FileAccess.open(file_path, FileAccess.READ)

	if file_access:
		var content = file_access.get_as_text()
		file_access.close()
		var parse_result = JSON.parse_string(content)
		spells = parse_result


func loadJSON2(file_path: String):
	var file_access = FileAccess.open(file_path, FileAccess.READ)

	if file_access:
		var content = file_access.get_as_text()
		file_access.close()
		var parse_result = JSON.parse_string(content)
		enemytypes = parse_result
			
func magicbutton(sender):
	if not spells[sender]["uses"] == -1:
		if not plspells[party.keys()[turn]][sender] >= spells[sender]["uses"]:
			spellname = sender
			if spells[sender]["trgt"] =="pl":
				casting = true
			$fight.hide()
			$magic.hide()
			$item.hide()
			$run.hide()
			chooseitem.emit()
		else:
			$info.text = "You have no more uses of the choosen spell. ("+str(spells[sender]["uses"])+")" + "\n"+"Rest at a save point to restore them."
	else:
		spellname = sender
		if spells[sender]["trgt"] =="pl":
			casting = true
		$fight.hide()
		$magic.hide()
		$item.hide()
		$run.hide()
		chooseitem.emit()
		
		
func itembutton(sender):
			item5 = true
			chooseitem.emit()
			var senderinfo = inventory[sender]
			#"name":{"hp":0,"effects":[],"buffs":[],"price":0,"special":[],"target":"You","desc":"","amount":1}
			if senderinfo["target"] =="You":
				select.emit()
				
				
				plhp[party.keys()[turn]]+=senderinfo["hp"]
				if plhp[party.keys()[turn]] > plmaxhp[party.keys()[turn]]:
					plhp[party.keys()[turn]] = plmaxhp[party.keys()[turn]]
				for effct in senderinfo["effects"]:
					if effct in plstatus[party.keys()[turn]]:
						plstatus[party.keys()[turn]].erase(effct)
				for stat in senderinfo["buffs"]:
					if stat == "def":
						plbuffs[party.keys()[turn]]["def"]=plbuffs[party.keys()[turn]]["def"]+0.05
					elif stat == "hp":
						plbuffs[party.keys()[turn]]["hp"]=plbuffs[party.keys()[turn]]["hp"]+0.05
					elif stat == "atk":
						
						plbuffs[party.keys()[turn]]["atk"]=plbuffs[party.keys()[turn]]["atk"]+0.05
					elif stat == "mgc":
						plbuffs[party.keys()[turn]]["mgc"]=plbuffs[party.keys()[turn]]["mgc"]+0.05
					elif stat == "-def":
						plbuffs[party.keys()[turn]]["def"]=plbuffs[party.keys()[turn]]["def"]-0.05
					elif stat == "-hp":
						plbuffs[party.keys()[turn]]["hp"]=plbuffs[party.keys()[turn]]["hp"]-0.05
					elif stat == "-atk":
						plbuffs[party.keys()[turn]]["atk"]=plbuffs[party.keys()[turn]]["atk"]-0.05
					elif stat == "-mgc":
						plbuffs[party.keys()[turn]]["mgc"]=plbuffs[party.keys()[turn]]["mgc"]-0.05
					select.emit()
			elif senderinfo["target"] =="Enemy":
				await target
				enemiesstats[enemiesstats.keys()[targetindex]]+=senderinfo["hp"]
				for effct in senderinfo["effects"]:
					enemiesstatus[enemiesstats.keys()[targetindex]].append(effct)
			if inventory[sender]["amount"]>1:
				inventory[sender]["amount"]-=1
			else:
				inventory.erase(sender)
			$info.text = "You have used the item."
			$fight.hide()
			$magic.hide()
			$item.hide()
			$run.hide()
			chooseitem.emit()
			done.emit()
		

func victory():
	for rewardindex in reward.keys():
		equipmentinventory[rewardindex] = reward[rewardindex]
	if boss:
		if str(forcedbool) == "/root/world/lighthouse/boss":
			$"../characters/player".ferryaccess = true
		if str(forcedbool) == "/root/world/fortress/boss":
			$"../characters/player".wyrmbell = true
		elif str(forcedbool) == "/root/world/crystalcaverns/boss":
			$"../characters/player".desertaccess = true
			$info.text = "You have obtained the Cooling Crystal"
			await done
	reward = {}
	battling = false
	for buttonchild in $"menu/the smith/buttons".get_children():
		buttonchild.queue_free()
	for buttonchild in $"menu/archibold/buttons".get_children():
		buttonchild.queue_free()
	for buttonchild in $"menu/gallous/buttons".get_children():
		buttonchild.queue_free()
	for buttonchild in $"menu/you/buttons".get_children():
		buttonchild.queue_free()
		
	var goldadded =0
	for enemy in enemies.keys():
		for player in party.keys():
			
			plxp[player] += ceil((enemiesstatslvl[enemy]**2 + 20)/5)
		goldadded += int(round(enemiesstatslvl[enemy]/2))
		$info.text = "Everyone has obtained " + str(ceil((enemiesstatslvl[enemy]**2 + 20)/5)) + " XP."
		await done
	$info.text = "The party has obtained "+str(goldadded)+"g"
	gold+=goldadded
	await done
	
	$info.text = "You are victorious!"
	await done
	if str(forcedbool) == "/root/world/glasscity/forcedencounter":
		$"../glasscity".trials["first"] = true
	if str(forcedbool) == "/root/world/glasscity/forcedencounter2":
		$"../glasscity".trials["second"] = true
	if str(forcedbool) == "/root/world/glasscity/forcedencounter3":
		$"../glasscity".trials["third"] = true
		$"../glasscity".keys["strength"] = true
		$"../characters/player".popup("You have obtained the Key of Strength!")
	if forcedbool != null:
		forced.append(forcedbool)
	end()
	
func start():
	battling = true
	$"../characters/player".moving = false
	$"../characters/player/loadingfade/AnimationPlayer".play("fadetoblack")
	
	await get_tree().create_timer(0.50/1.505).timeout
	show()
	$"../characters/player/puzzletimerdisplay/display".position = Vector2(177,-90)
	$"../characters/player/puzzletimerdisplay/display".scale = Vector2(7.565,7.565)
	$"../characters/player/Camera2D".enabled = false
	$"../characters/player".moving = false
	$Camera2D.enabled = true
	for spell in spells.values():
		if (playerclass == "demonic paladin" or playerclass == "sorcerer" or playerclass == "artificer") and (spell["align"] == "all" or spell["align"] == "de") and pllevel["player"]>=spell["lvl"] and not spell["name"] in plspells["player"].keys():
			plspells["player"][spell["name"]] = 0
			$info.text = str(party["player"])+" have learned "+str(spell["name"])
			$sec1timer.start()
			await done
		elif (playerclass == "angelic paladin" or playerclass == "sorcerer" or playerclass == "artificer") and spell["align"] == "an" and pllevel["player"]>=spell["lvl"] and not spell["name"] in plspells["player"].keys():
			plspells["player"][spell["name"]] = 0
			$info.text = str(party["player"])+" have learned "+str(spell["name"])
			await done
		if pllevel["smith"]>=spell["lvl"] and not spell["name"] in plspells["smith"].keys():
			plspells["smith"][spell["name"]] = 0
			$info.text = str(party["smith"])+" has learned "+str(spell["name"])
			await done
		if pllevel["archibold"]>=spell["lvl"] and not spell["name"] in plspells["archibold"].keys():
			plspells["archibold"][spell["name"]] = 0
			$info.text = str(party["archibold"])+" has learned "+str(spell["name"])
			await done
		var oppositemagic = "de" if (playerclass=="angelic paladin") else "an"
		if (spell["align"] == "all" or spell["align"] == oppositemagic) and pllevel["gallous"]>=spell["lvl"] and not spell["name"] in plspells["gallous"].keys():
			plspells["gallous"][spell["name"]] = 0
			$info.text = str(party["gallous"])+" has learned "+str(spell["name"])
			await done
	for player in party.keys():
		var increment = 0.05
		for equipment in plequipment[player].keys():
			for stat in plequipment[player][equipment]:
				
				if stat is String:
					
					if stat == "def":
						plbuffs[player]["def"]=plbuffs[player]["def"]+increment
					elif stat == "hp":
						plbuffs[player]["hp"]=plbuffs[player]["hp"]+increment
					elif stat == "atk":
						plbuffs[player]["atk"]=plbuffs[player]["atk"]+increment
					elif stat == "mgc":
						plbuffs[player]["mgc"]=plbuffs[player]["mgc"]+increment
					elif stat == "-def":
						plbuffs[player]["def"]=plbuffs[player]["def"]-increment
					elif stat == "-hp":
						plbuffs[player]["hp"]=plbuffs[player]["hp"]-increment
					elif stat == "-atk":
						plbuffs[player]["atk"]=plbuffs[player]["atk"]-increment
					elif stat == "-mgc":
						plbuffs[player]["mgc"]=plbuffs[player]["mgc"]-increment
			
		plmaxhp[player] = int(round(int(round(plmaxhpbse[player]+pllevel[player]**(1.2*(plmaxhpbse[player]/20.1))))*plbuffs[player]["hp"]))
		if plhp[player]>plmaxhp[player]:
				plhp[player]=plmaxhp[player]
	var spellbutton =load("res://spellbutton.tscn")
	
	for spell in plspells["smith"].keys():
		var spellbuttonnew = spellbutton.instantiate()
		
		spellbuttonnew.text = spell+"   "+str(plspells["smith"][spell]) + "/" + str(spells[spell]["uses"])
		$"menu/the smith/buttons".add_child(spellbuttonnew)
		spellbuttonnew.spell1 = spell
		spellbuttonnew.pressed.connect(magicbutton.bind(spell))
	for spell in plspells["archibold"].keys():
		var spellbuttonnew = spellbutton.instantiate()
		
		spellbuttonnew.text = spell+"   "+str(plspells["archibold"][spell]) + "/" + str(spells[spell]["uses"])
		$"menu/archibold/buttons".add_child(spellbuttonnew)
		spellbuttonnew.spell1 = spell
		spellbuttonnew.pressed.connect(magicbutton.bind(spell))
	for spell in plspells["player"].keys():
		var spellbuttonnew = spellbutton.instantiate()
		
		spellbuttonnew.text = spell+"   "+str(plspells["player"][spell]) + "/" + str(spells[spell]["uses"])
		$"menu/you/buttons".add_child(spellbuttonnew)
		spellbuttonnew.spell1 = spell
		spellbuttonnew.pressed.connect(magicbutton.bind(spell))
	for spell in plspells["gallous"].keys():
		var spellbuttonnew = spellbutton.instantiate()
		spellbuttonnew.text = spell+"   "+str(plspells["gallous"][spell]) + "/" + str(spells[spell]["uses"])
		
		$"menu/gallous/buttons".add_child(spellbuttonnew)
		spellbuttonnew.spell1 = spell
		spellbuttonnew.pressed.connect(magicbutton.bind(spell))
		
	$characters/player.hide()
	$characters/player2.hide()
	$characters/player3.hide()
	$characters/player4.hide()
	$enemies/enemy1.hide()
	$enemies/enemy2.hide()
	$enemies/enemy3.hide()
	$enemies/enemy4.hide()
	$enemies/enemy5.hide()
	$enemies/enemy6.hide()
	
	for player in party.keys():
		
		if party.keys().find(player) == 0:
			if not plhp[player] <= 0:
				$characters/player.show()
			else:
				$characters/player.hide()
		elif party.keys().find(player) == 1:
			if not plhp[player] <= 0:
				$characters/player2.show()
			else:
				$characters/player2.hide()
		elif party.keys().find(player) == 2:
			if not plhp[player] <= 0:
				$characters/player3.show()
			else:
				$characters/player3.hide()
		elif party.keys().find(player) == 3:
			if not plhp[player] <= 0:
				$characters/player4.show()
			else:
				$characters.player4.hide()
		

		
	
	turn = -1
	nextTurn()
	
	
func end():
	plbuffs = {"player":{"atk":1,"def":1,"mgc":1,"hp":1},"edward":{"atk":1,"def":1,"mgc":1,"hp":1},"mallouk":{"atk":1,"def":1,"mgc":1,"hp":1},"gallous":{"atk":1,"def":1,"mgc":1,"hp":1},"smith":{"atk":1,"def":1,"mgc":1,"hp":1},"archibold":{"atk":1,"def":1,"mgc":1,"hp":1}}
	forcedbool = null
	boss=false
	endatend = "nothing"
	damagegoal = 0
	
	for player in party.keys():
		if plxp[player] >= (pllevel[player]**2 + 20):
			plxp[player] -= (pllevel[player]**2 + 20)
			pllevel[player] += 1
			$info.text = str(party[player])+" has leveled up and is now level " + str(pllevel[player])+"!"
			await done
	for spell in spells.values():
		if (playerclass == "demonic paladin" or playerclass == "sorcerer" or playerclass == "artificer") and (spell["align"] == "all" or spell["align"] == "de") and pllevel["player"]>=spell["lvl"] and not spell["name"] in plspells["player"].keys():
			plspells["player"][spell["name"]] = 0
			$info.text = str(party["player"])+" have learned "+str(spell["name"])
			$sec1timer.start()
			await done
		elif (playerclass == "angelic paladin" or playerclass == "sorcerer" or playerclass == "artificer") and spell["align"] == "an" and pllevel["player"]>=spell["lvl"] and not spell["name"] in plspells["player"].keys():
			plspells["player"][spell["name"]] = 0
			$info.text = str(party["player"])+" have learned "+str(spell["name"])
			await done
		if pllevel["smith"]>=spell["lvl"] and not spell["name"] in plspells["smith"].keys():
			plspells["smith"][spell["name"]] = 0
			$info.text = str(party["smith"])+" has learned "+str(spell["name"])
			await done
		if pllevel["archibold"]>=spell["lvl"] and not spell["name"] in plspells["archibold"].keys():
			plspells["archibold"][spell["name"]] = 0
			$info.text = str(party["archibold"])+" has learned "+str(spell["name"])
			await done
		var oppositemagic = "de" if (playerclass=="angelic paladin") else "an"
		if (spell["align"] == "all" or spell["align"] == oppositemagic) and pllevel["gallous"]>=spell["lvl"] and not spell["name"] in plspells["gallous"].keys():
			plspells["gallous"][spell["name"]] = 0
			$info.text = str(party["gallous"])+" has learned "+str(spell["name"])
			await done
	for buttonchild in $"menu/the smith/buttons".get_children():
		buttonchild.queue_free()
	for buttonchild in $"menu/archibold/buttons".get_children():
		buttonchild.queue_free()
	for buttonchild in $"menu/gallous/buttons".get_children():
		buttonchild.queue_free()
	for buttonchild in $"menu/you/buttons".get_children():
		buttonchild.queue_free()
	$"../characters/player/loadingfade/AnimationPlayer".play("fadetoblack")
	
	await get_tree().create_timer(0.50/1.505).timeout
	$"../characters/player/puzzletimerdisplay/display".position = Vector2(-5,-26)
	$"../characters/player/puzzletimerdisplay/display".scale = Vector2(1,1)
	$"../characters/player/Camera2D".enabled = true
	$Camera2D.enabled = false
	$"../characters/player".moving = true
	battling = false
	hide()
	

	
func nextTurn():
	
	
	if not battling:
		return
	if boss:
		$enemies/enemy1.position = Vector2(400,0)
	else:
		$enemies/enemy1.position = Vector2(805,47)
	item5 = false
	for buttonchild in $"menu/the smith/buttons".get_children():
		var spell = buttonchild.spell1
		buttonchild.text = str(spell)+"  "+str(plspells["smith"][spell]) + "/" + str(spells[spell]["uses"])
	for buttonchild in $"menu/archibold/buttons".get_children():
		var spell = buttonchild.spell1
		buttonchild.text = str(spell)+"  "+str(plspells["archibold"][spell]) + "/" + str(spells[spell]["uses"])
	for buttonchild in $"menu/gallous/buttons".get_children():
		var spell = buttonchild.spell1
		buttonchild.text = str(spell)+"  "+str(plspells["gallous"][spell]) + "/" + str(spells[spell]["uses"])
	for buttonchild in $"menu/you/buttons".get_children():
		var spell = buttonchild.spell1
		buttonchild.text = str(spell)+"  "+str(plspells["player"][spell]) + "/" + str(spells[spell]["uses"])
	if not battling:
		return
	for player in party.keys():
		
		if party.keys().find(player) == 0:
			if not plhp[player] <= 0:
				$characters/player.show()
			else:
				$characters/player.hide()
		elif party.keys().find(player) == 1:
			if not plhp[player] <= 0:
				$characters/player2.show()
			else:
				$characters/player2.hide()
		elif party.keys().find(player) == 2:
			if not plhp[player] <= 0:
				$characters/player3.show()
			else:
				$characters/player3.hide()
		elif party.keys().find(player) == 3:
			if not plhp[player] <= 0:
				$characters/player4.show()
			else:
				$characters/player4.hide()
	if not battling:
		return
	for enemy in enemies.keys():
		if enemies.keys().find(enemy) == 0:
			if not enemiesstats[enemy] <= 0:
				$enemies/enemy1.show()
			else:
				$enemies/enemy1.hide()
		elif enemies.keys().find(enemy) == 1:
			if not enemiesstats[enemy] <= 0:
				$enemies/enemy2.show()
			else:
				$enemies/enemy2.hide()
		elif enemies.keys().find(enemy) == 2:
			if not enemiesstats[enemy] <= 0:
				$enemies/enemy3.show()
			else:
				$enemies/enemy3.hide()
		elif enemies.keys().find(enemy) == 3:
			if not enemiesstats[enemy] <= 0:
				$enemies/enemy4.show()
			else:
				$enemies/enemy4.hide()
		elif enemies.keys().find(enemy) == 4:
			if not enemiesstats[enemy] <= 0:
				$enemies/enemy5.show()
			else:
				$enemies/enemy5.hide()
		elif enemies.keys().find(enemy) == 5:
			if not enemiesstats[enemy] <= 0:
				$enemies/enemy6.show()
			else:
				$enemies/enemy6.hide()
				
	turn += 1
	if turn >len(party.keys())+ len(enemies.keys())-1:
		turn = 0
	if not battling:
		return
	var plzed = false
	for enemy in enemies.keys():
		if "brn" in enemiesstatus[enemy]:
			enemiesstats[enemy]-=ceil(enemiesstats[enemy]/20)
		if "bld" in enemiesstatus[enemy]:
			enemiesstats[enemy]-=ceil(enemiesstats[enemy]/10)
		if turn >= len(party.keys()):
			if "plz" in enemiesstatus[enemy] and enemies.keys()[turn-len(party.keys())] == enemy:
				plzed = true
			
		if randi()%2 == 0 and len(enemiesstatus[enemy]) > 0:
			enemiesstatus[enemy].remove_at(0)
	for player in party.keys():
		if "brn" in plstatus[player]:
			plhp[player]-=ceil(plhp[player]/20)
		if "bld" in plstatus[player]:
			plhp[player]-=ceil(plhp[player]/10)
		
		if turn <len(party.keys()):
			
			if "plz" in plstatus[player] and party.keys()[turn] == player:
				plzed = true
		
				
		if randi()%2 == 0 and len(plstatus[player]) > 0:
			
			plstatus[player].remove_at(0)
	
	
	var deadplayers = 0
	var deadenemies = 0
	if not battling:
		return
	
	for player in party.keys():
		if len(party.keys())-1 >= turn:
			if plhp[player] <= 0 and party.keys()[turn] == player:
				if str(party.values()[turn]) == "You":
					$info.text = str(party.values()[turn])  + " have been knocked out."
				else:
					$info.text = str(party.values()[turn])  + " has been knocked out."
				deadplayers+=1
				if not turn >len(party.keys())-1:
					turn+=1
				await done
	if not battling:
		return
	for enemy in enemies.keys():
		if enemiesstats[enemy] <= 0:
			deadenemies+=1

	if deadenemies >= len(enemies.keys()):
		victory()
	
	if deadplayers >= len(party.keys()):
		wipeout()
		
	if not battling:
		return
	if plzed != true:
		if turn >len(party.keys())+ len(enemies.keys())-1:
			turn = 0
		if turn < len(party.keys()):
			$fight.show()
			$magic.show()
			$item.show()
			$run.show()
			if turn == 0 and playerclass == "soldier" or playerclass == "ranger":
				$magic.hide()
			elif turn == 0:
				$magic.show()
			
			if turn == 0:
				$info.text = "What do you want to do?"
				$fighters.text ="You"+"\n"+"HP: "+str(plhp[party.keys()[turn]])+"/"+str(plmaxhp[party.keys()[turn]])
				for effect in plstatus[party.keys()[turn]]:
					$fighters.text+=" "+effect
			else:
				$info.text = "What does " + str(party.values()[turn]) + " want to do?"
				$fighters.text =str(party.values()[turn])+"\n"+"HP: "+str(plhp[party.keys()[turn]])+"/"+str(plmaxhp[party.keys()[turn]])
				for effect in plstatus[party.keys()[turn]]:
					$fighters.text+=" "+effect
			await begin
			await chooseitem
			$fight.hide()
			$magic.hide()
			$item.hide()
			$run.hide()
			$menu.hide()
			$menu/archibold.hide()
			$"menu/the smith".hide()
			$menu/you.hide()
			$menu/gallous.hide()
			$info.text = "To whom?"
			targetindex = null
			if item5 != true:
				await select
			target.emit()
		if turn >= len(party.keys()):
			if enemiesstats[enemiesstats.keys()[turn-len(party.keys())]] > 0:
				if enemies.keys()[turn-len(party.keys())][0] in enemysprites.keys():
					currentsprite[turn-len(party.keys())] = enemysprites[enemies.keys()[turn-len(party.keys())][0]]["attack"][0]
					loopcount2[turn-len(party.keys())] = randi_range(1,round(animationloopspeed/10))
				else:
					currentsprite[turn-len(party.keys())] = str("res://sprites/placeholderrpg1.png")
				
				var targetOfEnemyAI = randi_range(0,len(party.keys())-1)
				var loopcount = 0
				while plhp[party.keys()[targetOfEnemyAI]] <= 0 and deadplayers < len(party.keys()) and loopcount < 40:
					targetOfEnemyAI = randi_range(0,len(party.keys())-1)
					loopcount+=1
				
				var damageOfEnemyAI = int(round(int(round(enemydmg[enemies.keys()[turn-len(party.keys())][0]]+(0.002*enemiesstatslvl[enemies.keys()[turn-len(party.keys())]]**2)*randf_range(0.85,1.15)*((((1-(enemydmg[enemies.keys()[turn-len(party.keys())][0]]+(0.1*(enemiesstatslvl[enemies.keys()[turn-len(party.keys())]])**1.6)*log(enemydmg[enemies.keys()[turn-len(party.keys())][0]])/log(10)))/(1-(enemydmg[enemies.keys()[turn-len(party.keys())][0]]+(0.1*(101**1.6)*log(enemydmg[enemies.keys()[turn-len(party.keys())][0]])/log(10))))*60)/100))))/plbuffs[party.keys()[targetOfEnemyAI]]["def"]))
				$info.text = str(enemies[enemies.keys()[turn-len(party.keys())]]) + " is making an attack"
				$fighters.text =str(enemies[enemies.keys()[turn-len(party.keys())]])+"\n"+"HP: "+str(enemiesstats[enemies.keys()[turn-len(party.keys())]])+"/"+str(enemyhp[enemies.keys()[turn-len(party.keys())]])
				for effect in enemiesstatus[enemies.keys()[turn-len(party.keys())]]:
					$fighters.text+=" "+effect
				if not party.values()[targetOfEnemyAI] in counters:
					
					
					if randi_range(1,20)!=1 and not ("invincibility" in plstatus2[party.keys()[targetOfEnemyAI]]):
						
						plhp[party.keys()[targetOfEnemyAI]]-=damageOfEnemyAI
						for effct in enemyeffcts[enemies.keys()[turn-len(party.keys())][0]]:
							if randi_range(1,2)>1:
								plstatus[party.keys()[targetOfEnemyAI]].append(effct)
						if targetOfEnemyAI != 0:
							$info.text = party.values()[targetOfEnemyAI] + " has taken " + str(int(damageOfEnemyAI)) + " damage!"
						else:
							$info.text = party.values()[targetOfEnemyAI] + " have taken " + str(int(damageOfEnemyAI)) + " damage!"
					else:
						$info.text = str(enemies[enemies.keys()[turn-len(party.keys())]]) + " missed!"
						if "invincibility" in plstatus2[party.keys()[targetOfEnemyAI]]:
							if randi_range(0,2)>1:
								plstatus2[party.keys()[targetOfEnemyAI]].erase("invincibility" )
								
				else:
					$info.text = str(enemies[enemies.keys()[turn-len(party.keys())]]) + " has been countered!"
					enemiesstats[enemies.keys()[turn-len(party.keys())]]-= damageOfEnemyAI
					plhp[party.keys()[targetOfEnemyAI]]-= damageOfEnemyAI
					counters.erase(party.values()[targetOfEnemyAI])
					
				await done
				
				if boss == true and randi()%5 == 0:
					if enemies.keys()[turn-len(party.keys())][0] in enemysprites.keys():
						currentsprite[turn-len(party.keys())] = enemysprites[enemies.keys()[turn-len(party.keys())][0]]["attack"][0]
						loopcount2[turn-len(party.keys())] = randi_range(1,round(animationloopspeed/10))
					else:
						currentsprite[turn-len(party.keys())] = str("res://sprites/placeholderrpg1.png")
					$info.text = str(enemies[enemies.keys()[turn-len(party.keys())]]) + " is making a second attack!"
					await done
					targetOfEnemyAI = randi_range(0,len(party.keys())-1)
					loopcount = 0
					while plhp[party.keys()[targetOfEnemyAI]] <= 0 and deadplayers < len(party.keys()) and loopcount < 40:
						targetOfEnemyAI = randi_range(0,len(party.keys())-1)
						loopcount+=1
					damageOfEnemyAI = int(round(enemydmg[enemies.keys()[turn-len(party.keys())][0]]+(0.002*enemiesstatslvl[enemies.keys()[turn-len(party.keys())]]**2)*randf_range(0.85,1.15)*((((1-(enemydmg[enemies.keys()[turn-len(party.keys())][0]]+(0.1*(enemiesstatslvl[enemies.keys()[turn-len(party.keys())]])**1.6)*log(enemydmg[enemies.keys()[turn-len(party.keys())][0]])/log(10)))/(1-(enemydmg[enemies.keys()[turn-len(party.keys())][0]]+(0.1*(101**1.6)*log(enemydmg[enemies.keys()[turn-len(party.keys())][0]])/log(10))))*60)/100))/plbuffs[party.keys()[targetOfEnemyAI]]["def"]))
					$info.text = str(enemies[enemies.keys()[turn-len(party.keys())]]) + " is making a second attack!"
					$fighters.text =str(enemies[enemies.keys()[turn-len(party.keys())]])+"\n"+"HP: "+str(enemiesstats[enemies.keys()[turn-len(party.keys())]])+"/"+str(enemyhp[enemies.keys()[turn-len(party.keys())]])
					for effect in enemiesstatus[enemies.keys()[turn-len(party.keys())]]:
						$fighters.text+=" "+effect
					if not party.values()[targetOfEnemyAI] in counters:
						if randi_range(1,20)!=1 and not ("invincibility" in plstatus2[party.keys()[targetOfEnemyAI]]):
							
							plhp[party.keys()[targetOfEnemyAI]]-=damageOfEnemyAI
							for effct in enemyeffcts[enemies.keys()[turn-len(party.keys())][0]]:
								if randi_range(1,2)>1:
									plstatus[party.keys()[targetOfEnemyAI]].append(effct)
							if targetOfEnemyAI != 0:
								$info.text = party.values()[targetOfEnemyAI] + " has taken " + str(int(damageOfEnemyAI)) + " damage!"
							else:
								$info.text = party.values()[targetOfEnemyAI] + " have taken " + str(int(damageOfEnemyAI)) + " damage!"
						else:
							$info.text = str(enemies[enemies.keys()[turn-len(party.keys())]]) + " missed!"
							if "invincibility" in plstatus2[party.keys()[targetOfEnemyAI]]:
								if randi_range(0,2)>1:
									plstatus2[party.keys()[targetOfEnemyAI]].erase("invincibility" )
					else:
						$info.text = str(enemies[enemies.keys()[turn-len(party.keys())]]) + " has been countered!"
						enemiesstats[enemies.keys()[turn-len(party.keys())]]-= damageOfEnemyAI
						plhp[party.keys()[targetOfEnemyAI]]-= damageOfEnemyAI
						counters.erase(party.values()[targetOfEnemyAI])
						
					$fight.hide()
					$magic.hide()
					$item.hide()
					$run.hide()
					$menu.hide()
					$menu/archibold.hide()
					$"menu/the smith".hide()
					$menu/you.hide()
					$menu/gallous.hide()
					await done
			if endatend != "nothing":
				if endatend == "win":
					$info.text = "You have completed the challenge!"
					await done
					victory()
				elif endatend == "lose":
					$info.text = "You have failed the challenge."
					await done
					wipeout()
			else:
				nextTurn()
	else:
		$fight.hide()
		$magic.hide()
		$item.hide()
		$run.hide()
		$menu.hide()
		$menu/archibold.hide()
		$"menu/the smith".hide()
		$menu/you.hide()
		$menu/gallous.hide()
		if turn <len(party.keys()):
			if turn == 0:
					$info.text = "What do you want to do?"
					$fighters.text ="You"+"\n"+"HP: "+str(plhp[party.keys()[turn]])+"/"+str(plmaxhp[party.keys()[turn]])
					for effect in plstatus[party.keys()[turn]]:
						$fighters.text+=" "+effect
			else:
					$info.text = "What does " + str(party.values()[turn]) + " want to do?"
					$fighters.text =str(party.values()[turn])+"\n"+"HP: "+str(plhp[party.keys()[turn]])+"/"+str(plmaxhp[party.keys()[turn]])
					for effect in plstatus[party.keys()[turn]]:
						$fighters.text+=" "+effect
		$info.text = "They are paralyzed!"
		if turn >= len(party.keys()):
			$fighters.text =str(enemies[enemies.keys()[turn-len(party.keys())]])+"\n"+"HP: "+str(enemiesstats[enemies.keys()[turn-len(party.keys())]])+"/"+str(enemyhp[enemies.keys()[turn-len(party.keys())]])
		for player in party:
			if turn <len(party.keys()):
				
				if "plz" in plstatus[player] and party.keys()[turn] == player:
			
						plstatus[player].erase("plz")
		await done
		nextTurn()
	

func _on_fight_button_down() -> void:
	if not turn < len(party.keys()):
		return
	begin.emit()
	chooseitem.emit()
	await target
	if randi_range(1,20)!=1:
		var damage = int(round(1.7*int(round(plattack[party.keys()[turn]]+(0.1*(pllevel[party.keys()[turn]])**1.6)*log(plattack[party.keys()[turn]])/log(10)*randf_range(0.85,1.15)*plbuffs[party.keys()[turn]]["atk"]))))
		if damagegoal > 0:
			if damage >= damagegoal:
				endatend = "win"
			else:
				endatend = "lose"
		else:
			enemiesstats[enemiesstats.keys()[targetindex]]-=damage
		$info.text = str(enemies[enemies.keys()[targetindex]]) + " has taken " +str(int(damage)) + " damage!"
		if enemies.keys()[targetindex][0] in enemysprites.keys():
			currentsprite[targetindex] = enemysprites[enemies.keys()[targetindex][0]]["hurt"][0]
			loopcount2[targetindex] = randi_range(1,round(animationloopspeed/10))
		else:
			currentsprite[targetindex] = str("res://sprites/placeholderrpg1.png")
		
	else:
		$info.text = str(party.values()[turn]) + " missed!"
	await done
	nextTurn()
	

func _on_magic_button_down() -> void:
	if turn < len(party.keys()):
		if not(str(party.values()[turn]) == "Gallous" or (turn == 0 and (playerclass == "sorcerer" or playerclass == "artificer" or playerclass == "angelic paladin" or playerclass == "demonic paladin")) or  str(party.values()[turn]) == "Archibold" or  str(party.values()[turn]) == "The Smith"):
			return
	else:
		return
	begin.emit()
	
	$menu/title.text = "Spells"
	$menu.show()
	$menu/archibold.hide()
	$"menu/the smith".hide()
	$menu/you.hide()
	$menu/gallous.hide()
	
	if turn == 0:
		$menu/you.show()
	elif str(party.values()[turn]) == "Gallous":
		$menu/gallous.show()
	elif str(party.values()[turn]) == "Archibold":
		$menu/archibold.show()
	elif str(party.values()[turn]) == "The Smith":
		$"menu/the smith".show()
	await target
	
	plspells[party.keys()[turn]][spellname]+=1
	if casting == false:
		
		if spells[spellname]["trgts"] > 0:
			var damage = (spells[spellname]["dmg"])*(1+((60*((round(plmagic[party.keys()[turn]]+(0.1*(pllevel[party.keys()[turn]])**1.6)*log(plmagic[party.keys()[turn]])/log(10))/(plmagic[party.keys()[turn]]+(0.1*(101**1.6)*log(plmagic[party.keys()[turn]])/log(10))))))/100))*randf_range(0.75,1.25)*plbuffs[party.keys()[turn]]["mgc"]
			if damagegoal > 0:
				if damage >= damagegoal:
					endatend = "win"
				else:
					endatend = "lose"
			else:
				enemiesstats[enemiesstats.keys()[targetindex]]-=round(damage)
				if enemies.keys()[targetindex][0] in enemysprites.keys():
					currentsprite[targetindex] = enemysprites[enemies.keys()[targetindex][0]]["hurt"][0]
					loopcount2[targetindex] = randi_range(1,round(animationloopspeed/10))
				else:
					currentsprite[targetindex] = str("res://sprites/placeholderrpg1.png")
			
			if not boss:
				if "brn" in spells[spellname]["efcts"]:
					enemiesstatus[enemiesstats.keys()[targetindex]].append("brn")
				if "plz" in spells[spellname]["efcts"]:
					enemiesstatus[enemiesstats.keys()[targetindex]].append("plz")
				if "bld" in spells[spellname]["efcts"]:
					enemiesstatus[enemiesstats.keys()[targetindex]].append("bld")
			if "counter" in spells[spellname]["efcts"]:
				counters.append(str(party.values()[turn]))
			
				
			$info.text = str(enemies[enemies.keys()[targetindex]]) + " has taken " + str(int(damage)) + " damage!"
		elif spells[spellname]["trgts"] < 0:
			
			var damage = (spells[spellname]["dmg"])*(1+((60*((round(plmagic[party.keys()[turn]]+(0.1*(pllevel[party.keys()[turn]])**1.6)*log(plmagic[party.keys()[turn]])/log(10))/(plmagic[party.keys()[turn]]+(0.1*(101**1.6)*log(plmagic[party.keys()[turn]])/log(10))))))/100))*randf_range(0.75,1.25)*plbuffs[party.keys()[turn]]["mgc"]
			for targetindex in range(len(enemies.keys())):
				damage = (spells[spellname]["dmg"])*(1+((60*((round(plmagic[party.keys()[turn]]+(0.1*(pllevel[party.keys()[turn]])**1.6)*log(plmagic[party.keys()[turn]])/log(10))/(plmagic[party.keys()[turn]]+(0.1*(101**1.6)*log(plmagic[party.keys()[turn]])/log(10))))))/100))*randf_range(0.75,1.25)*plbuffs[party.keys()[turn]]["mgc"]
				if damagegoal > 0:
					if damage >= damagegoal:
						endatend = "win"
					else:
						endatend = "lose"
				else:
					enemiesstats[enemiesstats.keys()[targetindex]]-=round(damage)
					if enemies.keys()[targetindex][0] in enemysprites.keys():
						currentsprite[targetindex] = enemysprites[enemies.keys()[targetindex][0]]["hurt"][0]
						loopcount2[targetindex] = randi_range(1,round(animationloopspeed/10))
					else:
						currentsprite[targetindex] = str("res://sprites/placeholderrpg1.png")
				
				if "brn" in spells[spellname]["efcts"]:
					enemiesstatus[enemiesstats.keys()[targetindex]].append("brn")
				if "plz" in spells[spellname]["efcts"]:
					enemiesstatus[enemiesstats.keys()[targetindex]].append("plz")
				if "bld" in spells[spellname]["efcts"]:
					enemiesstatus[enemiesstats.keys()[targetindex]].append("bld")
				if "counter" in spells[spellname]["efcts"]:
					counters.append(str(party.values()[turn]))
				
					
			$info.text ="All enemies have taken " + str(int(damage)) + " damage!"
	else:
		var damage = abs(spells[spellname]["dmg"])+((60*((round(plmagic[party.keys()[turn]]+(0.1*(pllevel[party.keys()[turn]])**1.6)*log(plmagic[party.keys()[turn]])/log(10))/(plmagic[party.keys()[turn]]+(0.1*(101**1.6)*log(plmagic[party.keys()[turn]])/log(10))*randf_range(0.75,1.25)))))/100*plbuffs[party.keys()[turn]]["mgc"])
		
		plhp[party.keys()[abs(targetindex+1)]]+=round(damage)
		if plhp[party.keys()[abs(targetindex+1)]] >plmaxhp[party.keys()[abs(targetindex+1)]]:
			plhp[party.keys()[abs(targetindex+1)]] =plmaxhp[party.keys()[abs(targetindex+1)]]
		for stat in spells[spellname]["stats"]:
					if "atk" ==stat:
						plbuffs[party.keys()[turn]]["atk"]=plbuffs[party.keys()[turn]]["atk"]+0.1
						$info.text=party[party.keys()[abs(targetindex+1)]] + " attack stat has been buffed"
						await done
					if "mgc" ==stat:
						plbuffs[party.keys()[turn]]["mgc"]=plbuffs[party.keys()[turn]]["mgc"]+0.1
						$info.text=party[party.keys()[abs(targetindex+1)]] + " magic stat has been buffed"
						await done
					if stat=="def":
						
						plbuffs[party.keys()[turn]]["def"]=plbuffs[party.keys()[turn]]["def"]+0.1
						$info.text=party[party.keys()[abs(targetindex+1)]] + " defense stat has been buffed"
						await done
		if "counter" in spells[spellname]["efcts"]:
						counters.append(str(party.values()[turn]))
						$info.text=party[party.keys()[abs(targetindex+1)]] + " is ready to counter"
						await done
		if "invincibility" in spells[spellname]["efcts"]:
						plstatus2[party.keys()[turn]].append("invincibility")
						$info.text=party[party.keys()[abs(targetindex+1)]] + " has breached the relm of gods"
						
						await done
		$info.text = party[party.keys()[abs(targetindex+1)]] + " has healed " + str(int(damage)) + " damage!"
		$fighters.text =party[party.keys()[abs(targetindex+1)]]+"\n"+"HP: "+str(plhp[party.keys()[turn]])+"/"+str(plmaxhp[party.keys()[turn]])
	await done
	casting = false
	nextTurn()

func _on_item_button_down() -> void:
	if len(inventory.keys()) <=0:
		return
	for child in $"menu/items".get_children():
		child.queue_free()
	begin.emit()
	$menu/title.text = "Items"
	$menu.show()
	$"menu/items".show()
	var spellbutton =load("res://spellbutton.tscn")
	for spell in inventory.keys():
		var spellbuttonnew = spellbutton.instantiate()
		
		spellbuttonnew.text = str(inventory[spell]["amount"]) +"x"+spell+"      "+inventory[spell]["desc"]
		$"menu/items".add_child(spellbuttonnew)
		spellbuttonnew.pressed.connect(itembutton.bind(spell))
	await done
	nextTurn()

func _on_run_button_down() -> void:
	var runchance = randi_range(1,50)
	begin.emit()
	if runchance < 6:
		$info.text = "You have failed to escape from this battle"
		await done 
		chooseitem.emit()
		nextTurn()
	elif boss == true or forcedbool != null:
		$info.text = "You cannot escape from this battle"
	elif runchance > 5:
		chooseitem.emit()
		end()
		

func _on_done_button_down() -> void:
	if spellslotindex <= len(spells.keys()):
		$"menu/the smith/buttons".position.y-=48
		$"menu/you/buttons".position.y-=48
		$"menu/archibold/buttons".position.y-=48
		$"menu/gallous/buttons".position.y-=48
		spellslotindex +=1
	done.emit()

func _on_enemy_1_button_down() -> void:
	if not casting:
		targetindex = 0
		select.emit()
func _on_enemy_2_button_down() -> void:
	if not casting:
		targetindex = 1
		select.emit()
func _on_enemy_3_button_down() -> void:
	if not casting:
		targetindex = 2
		select.emit()
func _on_enemy_4_button_down() -> void:
	if not casting:
		targetindex = 3
		select.emit()
func _on_enemy_5_button_down() -> void:
	if not casting:
		targetindex = 4
		select.emit()
func _on_enemy_6_button_down() -> void:
	if not casting:
		targetindex = 5
		select.emit()

func _on_timer_timeout() -> void:
	sec1.emit()
func doneemit():
	done.emit()
	
	
func _on_player_1_button_down() -> void:
	if casting:
		targetindex = -1
		if plhp[party.keys()[abs(targetindex+1)]] <=0:
			$info.text = "That guy's dead"
		else:
			select.emit()
func _on_player_2_button_down() -> void:
	if casting:
		targetindex = -2
		if plhp[party.keys()[abs(targetindex+1)]] <=0:
			$info.text = "That guy's dead"
		else:
			select.emit()
func _on_player_3_button_down() -> void:
	if casting:
		targetindex = -3
		if plhp[party.keys()[abs(targetindex+1)]] <=0:
			$info.text = "That guy's dead"
		else:
			select.emit()
func _on_player_4_button_down() -> void:
	if casting:
		targetindex = -4
		if plhp[party.keys()[abs(targetindex+1)]] <=0:
			$info.text = "That guy's dead"
		else:
			select.emit()

var previouscurrentframes = []
func _process(delta: float) -> void:
	for enemyloopervar in range(len(loopcount2)):
		loopcount2[enemyloopervar]+=delta
		
		if loopcount2[enemyloopervar] > animationloopspeed*10:
			loopcount2[enemyloopervar] =0
	previouscurrentframes = currentsprite.duplicate()
	
	for enemy in enemies.keys():
		for enemyid in range(6):
			var working = false
			if enemies.keys().find(enemy) == enemyid:
				
				if not enemiesstats[enemy] <= 0:
					
					get_node("enemies/enemy"+str(enemyid+1)).show()
				else:
					get_node("enemies/enemy"+str(enemyid+1)).hide()
				if enemy[0] in enemysprites.keys():
					
					if loopcount2[enemyid] >= animationloopspeed:
						
						loopcount2[enemyid] = randi_range(0,round(animationloopspeed/10))
						for enemyspritegroup in enemysprites[enemy[0]].values():
							if not working:
								
								for enemyspritegroupid in range(len(enemyspritegroup)):
									if not working:
										if enemyspritegroup[enemyspritegroupid] == currentsprite[enemyid]:
											
											if enemyspritegroupid >= len(enemyspritegroup)-1:
												currentsprite[enemyid] = enemysprites[enemy[0]]["idle"][0]
												
											else:
												currentsprite[enemyid] = enemyspritegroup[enemyspritegroupid+1]
												
												
											working = true

					if currentsprite[enemyid] != previouscurrentframes[enemyid]:
						get_node("enemies/enemy"+str(enemyid+1)).texture_normal=load(currentsprite[enemyid])
						get_node("enemies/enemy"+str(enemyid+1)).modulate=enemycolor[enemy[0]]
				else:
					currentsprite[enemyid] = str("res://sprites/placeholderrpg1.png")
	for path in forced:
		
		if get_node_or_null(path)!=null:
			
			get_node(path).queue_free()
	

func _on_up_button_down() -> void:
	if spellslotindex > 0:
		$"menu/the smith/buttons".position.y+=48
		$"menu/you/buttons".position.y+=48
		$"menu/archibold/buttons".position.y+=48
		$"menu/gallous/buttons".position.y+=48
		spellslotindex -=1

func save():
	pass

func sleep():
	for player in party.keys():
		plhp[player]=plmaxhp[player]
		plstatus[player] =[]
		for spell in plspells[player].keys():
			plspells[player][spell]=0

func pray():
	for player in party.keys():
		plstatus[player] =[]
		for spell in plspells[player].keys():
			plspells[player][spell]=0

extends CanvasLayer

var playernodes = ["player","player2","player3","player4"]
var itemslotnodes = ["item","item2","item3"]
@onready var arena = $"../../../arena"

func _ready():
	arena = $"../../../arena"
	var currentnode = null
	for playernode in playernodes:
		for itemslot in itemslotnodes:
			currentnode = get_node(playernode+"/"+itemslot)
			if len($"../../../arena".party)-1 >=playernodes.find(playernode):
				currentnode.user = $"../../../arena".party.keys()[playernodes.find(playernode)]
				currentnode.show()
			else:
				currentnode.hide()
			currentnode.slotnum = itemslotnodes.find(itemslot)
			currentnode.pressed.connect(itembuttonpressed.bind(currentnode.get_path()))


func _on_items_button_down() -> void:
	$stuff.show()
	for child in $"stuff/items".get_children():
		child.queue_free()
	var spellbutton =load("res://label.tscn")
	for spell in $"../../../arena".inventory.keys():
		var spellbuttonnew = spellbutton.instantiate()
		spellbuttonnew.text = str($"../../../arena".inventory[spell]["amount"]) +"x"+spell+"      "+$"../../../arena".inventory[spell]["desc"]
		
		$stuff/items.add_child(spellbuttonnew)
		

func _on_equipment_button_down() -> void:
	var spellbutton =load("res://label.tscn")
	$stuff.show()
	
	for child in $"stuff/items".get_children():
		child.queue_free()

	for spell in $"../../../arena".equipmentinventory.keys():
		var addition = ""
		var atk = ""
		var def = ""
		var mgc = ""
		var hp = ""
		for plus in $"../../../arena".equipmentinventory[spell]:
			if not plus is int:
				if plus == "atk":
					atk += "+"
				elif plus == "-atk":
					atk += "-"
				elif plus == "def":
					def += "+"
				elif plus == "-def":
					def += "-"
				elif plus == "mgc":
					mgc += "+"
				elif plus == "-mgc":
					mgc += "-"
				elif plus == "hp":
					hp += "+"
				elif plus == "-hp":
					hp += "-"
		if atk !="":
			atk +="ATK"
			addition +=atk+"  "
		if def !="":
			def +="DEF"
			addition +=def+"  "
		if mgc !="":
			mgc +="MGC"
			addition +=mgc+"  "
		if hp !="":
			hp +="HP"
			addition +=hp+"  "
		var spellbuttonnew = spellbutton.instantiate()
		spellbuttonnew.text = str($"../../../arena".equipmentinventory[spell][0]) +"x"+spell+"   "+addition
		
		$stuff/items.add_child(spellbuttonnew)
		
		
func itembuttonpressed(path):


	_change_equipment(get_node(path).user,get_node(path).slotnum)
	
	
func _change_equipment(player,index) -> void:
	var spellbutton =load("res://spellbutton.tscn")
	for child in $"stuff/items".get_children():
		child.queue_free()
	
	for spell in $"../../../arena".equipmentinventory.keys():
		var addition = ""
		var atk = ""
		var def = ""
		var mgc = ""
		var hp = ""
		for plus in $"../../../arena".equipmentinventory[spell]:
			if plus is int:
				pass
			elif plus == "atk":
				atk += "+"
			elif plus == "-atk":
				atk += "-"
			elif plus == "def":
				def += "+"
			elif plus == "-def":
				def += "-"
			elif plus == "mgc":
				mgc += "+"
			elif plus == "-mgc":
				mgc += "-"
			elif plus == "hp":
				hp += "+"
			elif plus == "-hp":
				hp += "-"
		if atk !="":
			atk +="ATK"
			addition +=atk+"  "
		if def !="":
			def +="DEF"
			addition +=def+"  "
		if mgc !="":
			mgc +="MGC"
			addition +=mgc+"  "
		if hp !="":
			hp +="HP"
			addition +=hp+"  "
		var spellbuttonnew = spellbutton.instantiate()
		spellbuttonnew.text = str($"../../../arena".equipmentinventory[spell][0]) +"x"+spell+"   "+addition
		spellbuttonnew.pressed.connect(changeitem.bind(spell,player,index))
		$stuff.show()
		$stuff/items.add_child(spellbuttonnew)


func changeitem(item,player,slot):
	$stuff.hide()

	if not $"../../../arena".equipmentinventory[item] in $"../../../arena".plequipment[player]:
			if len($"../../../arena".plequipment[player].keys())-1 >= slot:
				
				if not $"../../../arena".plequipment[player].keys()[slot] in $"../../../arena".equipmentinventory:
					$"../../../arena".equipmentinventory[$"../../../arena".plequipment[player].keys()[slot]] = $"../../../arena".plequipment[player][$"../../../arena".plequipment[player].keys()[slot]]
					$"../../../arena".plequipment[player].erase($"../../../arena".plequipment[player].keys()[slot])
					$"../../../arena".plequipment[player][item] = $"../../../arena".equipmentinventory[item]
					if $"../../../arena".equipmentinventory[item][0] < 2:
						$"../../../arena".equipmentinventory.erase(item)
					else:
						$"../../../arena".equipmentinventory[item][0]-=1
					
				else:
					$"../../../arena".equipmentinventory[$"../../../arena".plequipment[player].keys()[slot]][0] +=1
					
					$"../../../arena".plequipment[player].erase($"../../../arena".plequipment[player].keys()[slot])
					
					$"../../../arena".plequipment[player][item] = $"../../../arena".equipmentinventory[item]
					if $"../../../arena".equipmentinventory[item][0] < 2:
						$"../../../arena".equipmentinventory.erase(item)
					else:
						$"../../../arena".equipmentinventory[item][0]-=1
		
			else:
				$"../../../arena".plequipment[player][item] = $"../../../arena".equipmentinventory[item]
				if $"../../../arena".equipmentinventory[item][0] < 2:
						$"../../../arena".equipmentinventory.erase(item)
				else:
						$"../../../arena".equipmentinventory[item][0]-=1
	else:
			$"..".popup("You cannot equip two of the same item.")
	
	
	
func _process(delta: float) -> void:
	var currentnode = null
	for playernode in playernodes:
		for itemslot in itemslotnodes:
			currentnode = get_node(playernode+"/"+itemslot)
			if len(arena.party)-1 >=playernodes.find(playernode):
				currentnode.user = arena.party.keys()[playernodes.find(playernode)]
				currentnode.show()
			else:
				currentnode.hide()
			currentnode.slotnum = itemslotnodes.find(itemslot)
			if len(arena.party)-1 >=playernodes.find(playernode):
				if len($"../../../arena".plequipment[$"../../../arena".party.keys()[playernodes.find(playernode)]].keys())-1 >=itemslotnodes.find(itemslot):
					currentnode.text = $"../../../arena".plequipment[$"../../../arena".party.keys()[playernodes.find(playernode)]].keys()[itemslotnodes.find(itemslot)]
				else:
					currentnode.text = "Nothing"

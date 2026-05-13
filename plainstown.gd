extends Node2D

signal done
var commongoods = {"Apple":{"hp":5,"effects":[],"buffs":[],"price":5,"special":[],"target":"You","desc":"Heals 5 Hp","amount":1},"Rasher":{"hp":10,"effects":[],"buffs":[],"price":10,"special":[],"target":"You","desc":"Heals 10 Hp","amount":1},"Insta-Flame":{"hp":-5,"effects":["brn"],"buffs":[],"price":5,"special":[],"target":"Enemy","desc":"Burns the enemy","amount":1},"Small Bomb":{"hp":-10,"effects":[],"buffs":[],"price":30,"special":[],"target":"Enemy","desc":"Does 10 damage","amount":1},"Heal Burn":{"hp":0,"effects":["brn"],"buffs":[],"price":20,"special":[],"target":"You","desc":"Heals burns","amount":1},"Basic Hp Potion":{"hp":20,"effects":[],"buffs":[],"price":30,"special":[],"target":"You","desc":"Heals 20 Hp","amount":1},"Basic Defense Potion":{"hp":0,"effects":[],"buffs":["def"],"price":30,"special":[],"target":"You","desc":"Raises defense","amount":1},"Basic Attack Potion":{"hp":0,"effects":[],"buffs":["atk"],"price":30,"special":[],"target":"You","desc":"Raises attack","amount":1}}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$dialouge.text = "Plainstown"
	
	$"../characters/player".moving = false
	$Camera2D.make_current()
	
func _process(delta: float) -> void:
	$goldamount.text = str(int(round($"../arena".gold)))+"g"

func buyequipment(itemdesc,item,price):
	if $"../arena".gold >= price:
		if item in $"../arena".equipmentinventory.keys():
			$"../arena".equipmentinventory[item][0] +=1
		else:
			$"../arena".equipmentinventory[item] = itemdesc
		$"../arena".gold -= price
		$dialouge.text = "Item Purchased"
	else:
		$dialouge.text = "You seem to be too poor to purchase this item." +"  Come Back when your a little mmmmmmm... richer."

func buyitem(itemdesc,item,price):
	if $"../arena".gold >= price:
		if item in $"../arena".inventory.keys():
			$"../arena".inventory[item]["amount"] +=1
		else:
			$"../arena".inventory[item]=itemdesc
		$"../arena".gold -= price
		$dialouge.text = "Item Purchased"
	else:
		$dialouge.text = "You seem to be too poor to purchase this item." +"  Come Back when your a little mmmmmmm... richer."
	
	
func _on_smith_button_down() -> void:
	$menu.show()
	$dialouge.text = "Blacksmith Colter:"+"\n"+"Welcome to the Plainstown Smithy."
	var items = {"Iron Shortsword":[1,"atk"],"Iron Longsword":[1,"atk","atk","-def"],"Leather Armor":[1,"def"],"Basic Bow":[1,"atk","atk","-mgc"]}
	var itemsprice = {"Iron Shortsword":30,"Iron Longsword":60,"Leather Armor":100,"Basic Bow":50}
	$menu/label.text = "Smithy"
	var sale =load("res://spellbutton.tscn")
	for item in items.keys():
		var itembuttonnew = sale.instantiate()
		$"menu/buttons".add_child(itembuttonnew)
		itembuttonnew.text = item + ": "+str(itemsprice[item])+"g"
		itembuttonnew.pressed.connect(buyequipment.bind(items[item],item,itemsprice[item]))


func _on_generalstore_button_down() -> void:
	$menu.show()
	$dialouge.text = "Shopkeep Ryouta:"+"\n"+"Welcome to the Plainstown General Store."
	var items = {"Apple":{"hp":5,"effects":[],"buffs":[],"price":5,"special":[],"target":"You","desc":"Heals 5 Hp","amount":1},"Rasher":{"hp":10,"effects":[],"buffs":[],"price":10,"special":[],"target":"You","desc":"Heals 10 Hp","amount":1},"Insta-Flame":{"hp":-5,"effects":["brn"],"buffs":[],"price":5,"special":[],"target":"Enemy","desc":"Burns the enemy","amount":1},"Small Bomb":{"hp":-10,"effects":[],"buffs":[],"price":30,"special":[],"target":"Enemy","desc":"Does 10 damage","amount":1},"Heal Burn":{"hp":0,"effects":["brn"],"buffs":[],"price":20,"special":[],"target":"You","desc":"Heals burns","amount":1}}
	$menu/label.text = "General Store"
	var sale =load("res://spellbutton.tscn")
	for item in items.keys():
		var itembuttonnew = sale.instantiate()
		
		$"menu/buttons".add_child(itembuttonnew)
		itembuttonnew.text = item + ": "+str(items[item]["price"])+"g"
		itembuttonnew.pressed.connect(buyitem.bind(items[item],item,items[item]["price"]))


func _on_potionstore_button_down() -> void:
	$menu.show()
	$dialouge.text = "Alchemist Sophie:"+"\n"+"Welcome to the Plainstown Potion Shop."
	var items = {"Basic Hp Potion":{"hp":20,"effects":[],"buffs":[],"price":30,"special":[],"target":"You","desc":"Heals 20 Hp","amount":1},"Basic Defense Potion":{"hp":0,"effects":[],"buffs":["def"],"price":30,"special":[],"target":"You","desc":"Raises defense","amount":1},"Basic Attack Potion":{"hp":0,"effects":[],"buffs":["atk"],"price":30,"special":[],"target":"You","desc":"Raises attack","amount":1}}
	$menu/label.text = "Potion Store"
	var sale =load("res://spellbutton.tscn")
	for item in items.keys():
		var itembuttonnew = sale.instantiate()
		$"menu/buttons".add_child(itembuttonnew)
		itembuttonnew.text = item + ": "+str(items[item]["price"])+"g"
		itembuttonnew.pressed.connect(buyequipment.bind(items[item],item,items[item]["price"]))


func _on_townhall_button_down() -> void:
	$menu.show()
	$dialouge.text = "Who would you like to talk to"
	var items = {"Mayor Adrine":["Welcome to our town traveller, feel free to look around!"],"Resident Dirce":["We live close to the farmlands so food is never a problem."],"Resident Conn":["I have heard rumors of a cave to the south.","Supposedly it contains hidden riches valueing to thousands of gold!","I hope to find it one day."]}
	$menu/label.text = "Town Hall"
	var sale =load("res://spellbutton.tscn")
	for item in items.keys():
		var itembuttonnew = sale.instantiate()
		$"menu/buttons".add_child(itembuttonnew)
		itembuttonnew.text = item
		itembuttonnew.pressed.connect(talk.bind(items[item]))

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ENTER or event.keycode == KEY_SPACE: 
			done.emit()
			
func talk(dialouge):
	$menu/buttons.hide()
	for piece in dialouge:
		$menu/label.text = piece
		await done
	$menu/buttons.show()
	

func _on_inn_button_down() -> void:
	$menu.show()
	$dialouge.text = "Innkeeper Thors:"+"\n"+"5 gold for a room, rest yourself before the journey."
	$menu/label.text = "Inn"
	var sale =load("res://spellbutton.tscn")

	var itembuttonnew = sale.instantiate()
	$"menu/buttons".add_child(itembuttonnew)
	itembuttonnew.text = "Sleep for the Night?"
	itembuttonnew.pressed.connect(sleep.bind())

signal timerdone 

func sleep():
	if $"../arena".gold >= 5:
		$menu/buttons.hide()
		$"../arena".gold -=5
		$dialouge.text = "Sleeping..."
		$"../arena".save()
		$"../arena".sleep()
		$Timer.start()
		await timerdone
		
		$dialouge.text = "You awake rested"
		$menu/buttons.show()
	else:
		$dialouge.text = "You seem to be too poor to sleep here." +"  Come Back when your a little mmmmmmm... richer."


func _on_storerooms_button_down() -> void:
	$menu.show()
	$dialouge.text = "You entered the storerooms"
	$menu/label.text = "Storerooms"
	var sale =load("res://spellbutton.tscn")

	var itembuttonnew = sale.instantiate()
	$"menu/buttons".add_child(itembuttonnew)
	itembuttonnew.text = "Steal an item?"
	itembuttonnew.pressed.connect(steal.bind())


func _on_church_button_down() -> void:
	$menu.show()
	$dialouge.text = "Pastor Eldon:"+"\n"+"Welcome traveller, to the Church of the Principles."
	$menu/label.text = "Church of the Principles"
	var sale =load("res://spellbutton.tscn")

	var itembuttonnew = sale.instantiate()
	$"menu/buttons".add_child(itembuttonnew)
	itembuttonnew.text = "Pray?"
	itembuttonnew.pressed.connect(pray.bind())


func steal():
	var itemstolen = commongoods.keys()[randi_range(0,len(commongoods)-1)]
	if randi_range(1,3) > 1:
		$dialouge.text = "You have succeded in stealing a "+itemstolen
		$"../arena".inventory[itemstolen]=commongoods[itemstolen]
	else:
		$dialouge.text = "You have been caught!"
		var enemycount =1
		var level = [1]
		var generatedenemy = ["plasticsoldier"]
		var namenemy = ["Plainstown Guard"]
		var hp1 = [500]
		$"../arena".enemies = {}
		$"../arena".enemiesstats = {}
		$"../arena".enemiesstatus = {}
		$"../arena".enemiesstatslvl = {}
		$"../arena".enemyhp = {}
		$"../arena".stolen = commongoods[itemstolen]["price"]*2
		for creature in range(enemycount):
			$"../arena".enemies[generatedenemy[creature]] = namenemy[creature]
			$"../arena".enemyhp[generatedenemy[creature]]=hp1[creature]
			$"../arena".enemiesstats[generatedenemy[creature]] = hp1[creature]
			$"../arena".enemiesstatus[generatedenemy[creature]] = []
			$"../arena".enemiesstatslvl[generatedenemy[creature]] = level[creature]
		$"../arena".start()

		

func pray():
		$dialouge.text = "You have been blessed,  spells have been restored and effects have been healed."
		
		$"../arena".pray()
		
		
func _on_timer_timeout() -> void:
	timerdone.emit()


func _on_house_1_button_down() -> void:
	$menu.show()
	$dialouge.text = "You have entered a random person's house"
	$menu/label.text = "Some dude's house"
	var sale =load("res://spellbutton.tscn")

	var itembuttonnew = sale.instantiate()
	$"menu/buttons".add_child(itembuttonnew)
	itembuttonnew.text = "Steal an item?"
	itembuttonnew.pressed.connect(steal.bind())

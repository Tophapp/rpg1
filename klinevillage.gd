extends Node2D

signal done
var commongoods = {"Pear":{"hp":15,"effects":[],"buffs":[],"price":25,"special":[],"target":"You","desc":"Heals 15 Hp","amount":1},"Subterranean Boar Meat":{"hp":30,"effects":[],"buffs":[],"price":70,"special":[],"target":"You","desc":"Heals 30 Hp","amount":1},"Freeze Tome":{"hp":-15,"effects":["plz"],"buffs":[],"price":100,"special":[],"target":"Enemy","desc":"Freezes the enemy","amount":1},"Comedy Mask":{"hp":100,"effects":[],"buffs":[],"price":300,"special":[],"target":"You","desc":"Heals 100 Damage","amount":1},"Heal Burn":{"hp":0,"effects":["brn"],"buffs":[],"price":20,"special":[],"target":"You","desc":"Heals burns","amount":1},"Heal Bleed":{"hp":0,"effects":["bleed"],"buffs":[],"price":40,"special":[],"target":"You","desc":"Heals Bleeding","amount":1},"Advanced Hp Potion":{"hp":40,"effects":[],"buffs":[],"price":100,"special":[],"target":"You","desc":"Heals 40 Hp","amount":1},"Advanced Defense Potion":{"hp":0,"effects":[],"buffs":["def","def"],"price":60,"special":[],"target":"You","desc":"Raises defense","amount":1},"Advanced Attack Potion":{"hp":0,"effects":[],"buffs":["atk","atk"],"price":60,"special":[],"target":"You","desc":"Raises attack","amount":1},"Basic Magic Potion":{"hp":0,"effects":[],"buffs":["mgc"],"price":40,"special":[],"target":"You","desc":"Raises magical ability","amount":1}}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$dialouge.text = "Kline Village"
	
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
	$dialouge.text = "Blacksmith Drechmold:"+"\n"+"Welcome to the Kline Village Smithy."
	var items = {"Bronze Shortsword":[1,"atk","atk"],"Bronze Longsword":[1,"atk","atk","atk","-def"],"Great Helm":[1,"def","def","atk","atk"],"Ripper Blades":[1,"atk","atk","-mgc","atk","atk","-mgc","atk","-mgc","-hp"],"Laser Sword":[1,"atk","atk","atk","atk","atk","def","def","def","def"],"Infernal Bane":[1,"mgc","mgc","mgc","atk","atk","atk"]}
	var itemsprice = {"Bronze Shortsword":200,"Bronze Longsword":300,"Great Helm":500,"Ripper Blades":1000,"Laser Sword":2500,"Infernal Bane":700}
	$menu/label.text = "Smithy"
	var sale =load("res://spellbutton.tscn")
	for item in items.keys():
		var itembuttonnew = sale.instantiate()
		$"menu/buttons".add_child(itembuttonnew)
		itembuttonnew.text = item + ": "+str(itemsprice[item])+"g"
		itembuttonnew.pressed.connect(buyequipment.bind(items[item],item,itemsprice[item]))


func _on_generalstore_button_down() -> void:
	$menu.show()
	$dialouge.text = "Shopkeep Imlet:"+"\n"+"Welcome to the Kline Village General Store."
	var items = {"Pear":{"hp":15,"effects":[],"buffs":[],"price":25,"special":[],"target":"You","desc":"Heals 15 Hp","amount":1},"Subterranean Boar Meat":{"hp":30,"effects":[],"buffs":[],"price":70,"special":[],"target":"You","desc":"Heals 30 Hp","amount":1},"Freeze Tome":{"hp":-15,"effects":["plz"],"buffs":[],"price":100,"special":[],"target":"Enemy","desc":"Freezes the enemy","amount":1},"Comedy Mask":{"hp":100,"effects":[],"buffs":[],"price":300,"special":[],"target":"You","desc":"Heals 100 Damage","amount":1},"Heal Burn":{"hp":0,"effects":["brn"],"buffs":[],"price":20,"special":[],"target":"You","desc":"Heals burns","amount":1},"Heal Bleed":{"hp":0,"effects":["bleed"],"buffs":[],"price":40,"special":[],"target":"You","desc":"Heals Bleeding","amount":1}}
	$menu/label.text = "General Store"
	var sale =load("res://spellbutton.tscn")
	for item in items.keys():
		var itembuttonnew = sale.instantiate()
		
		$"menu/buttons".add_child(itembuttonnew)
		itembuttonnew.text = item + ": "+str(items[item]["price"])+"g"
		itembuttonnew.pressed.connect(buyitem.bind(items[item],item,items[item]["price"]))


func _on_potionstore_button_down() -> void:
	$menu.show()
	$dialouge.text = "Alchemist Velmont:"+"\n"+"Welcome to the Kline Village Potion Shop."
	var items = {"Advanced Hp Potion":{"hp":40,"effects":[],"buffs":[],"price":100,"special":[],"target":"You","desc":"Heals 40 Hp","amount":1},"Advanced Defense Potion":{"hp":0,"effects":[],"buffs":["def","def"],"price":60,"special":[],"target":"You","desc":"Raises defense","amount":1},"Advanced Attack Potion":{"hp":0,"effects":[],"buffs":["atk","atk"],"price":60,"special":[],"target":"You","desc":"Raises attack","amount":1},"Basic Magic Potion":{"hp":0,"effects":[],"buffs":["mgc"],"price":40,"special":[],"target":"You","desc":"Raises magical ability","amount":1}}
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
	var items = {"Mayor Desmond":["..."],"Resident Blushk":["This town has lost a lot of its spark.","Ever since the war."],"Resident Kirshma":["Why..."],"Cartographer Quetzal":["Bones...","Why are there so many bones...","Heaven..."]}
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
	$dialouge.text = "Innkeeper Trimm:"+"\n"+"7 gold for a room, rest yourself before the journey."
	$menu/label.text = "Inn"
	var sale =load("res://spellbutton.tscn")

	var itembuttonnew = sale.instantiate()
	$"menu/buttons".add_child(itembuttonnew)
	itembuttonnew.text = "Sleep for the Night?"
	itembuttonnew.pressed.connect(sleep.bind())

signal timerdone 

func sleep():
	if $"../arena".gold >= 7:
		$menu/buttons.hide()
		$"../arena".gold -=7
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
	$dialouge.text = "Pastor Garendish:"+"\n"+"Welcome traveller, to the Church of the Sorrows."
	$menu/label.text = "Church of the Sorrows"
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
		var namenemy = ["Guard"]
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

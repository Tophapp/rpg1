extends Node2D

signal done
var commongoods = {"Apple":{"hp":5,"effects":[],"buffs":[],"price":5,"special":[],"target":"You","desc":"Heals 5 Hp","amount":1},"Rasher":{"hp":10,"effects":[],"buffs":[],"price":10,"special":[],"target":"You","desc":"Heals 10 Hp","amount":1},"Basic Hp Potion":{"hp":20,"effects":[],"buffs":[],"price":30,"special":[],"target":"You","desc":"Heals 20 Hp","amount":1},"Basic Defense Potion":{"hp":0,"effects":[],"buffs":["def"],"price":30,"special":[],"target":"You","desc":"Raises defense","amount":1},"Basic Attack Potion":{"hp":0,"effects":[],"buffs":["atk"],"price":30,"special":[],"target":"You","desc":"Raises attack","amount":1},"Dragon Fruit":{"hp":100,"effects":[],"buffs":[],"price":400,"special":[],"target":"You","desc":"Heals 100 Hp","amount":1},"Melon":{"hp":20,"effects":[],"buffs":["def","def"],"price":100,"special":[],"target":"You","desc":"Raises defense and provides a light snack","amount":1},"Saffron":{"hp":15,"effects":[],"buffs":["mgc","mgc","mgc","mgc","mgc","mgc","mgc","mgc","mgc","mgc"],"price":1000,"special":[],"target":"You","desc":"Increases magical ability","amount":1},"Durian":{"hp":-20,"effects":[],"buffs":["def","def"],"price":70,"special":[],"target":"You","desc":"Spiky but hearty","amount":1}}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$dialouge.text = "Port Town"
	
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
	$dialouge.text = "Weapons Trader Billy:"+"\n"+"Come on in and buy some gear!"
	var items = {"Adamantite Helmet":[1,"def","def","def"],"Adamantite Chestplate":[1,"def","def","def","def"],"Adamantite Hammer":[1,"-def","-def","-def","atk","atk","atk","atk","atk"],"Adamantite Dagger":[1,"hp","hp","atk","atk"]}
	var itemsprice = {"Adamantite Helmet":500,"Adamantite Chestplate":700,"Adamantite Hammer":1200,"Adamantite Dagger":800}
	$menu/label.text = "Weapons Store"
	var sale =load("res://spellbutton.tscn")
	for item in items.keys():
		var itembuttonnew = sale.instantiate()
		$"menu/buttons".add_child(itembuttonnew)
		itembuttonnew.text = item + ": "+str(itemsprice[item])+"g"
		itembuttonnew.pressed.connect(buyequipment.bind(items[item],item,itemsprice[item]))

func _on_rare_smith_button_down() -> void:
	$menu.show()
	$dialouge.text = "Weaponsmith Octavious:"+"\n"+"Hello there..."
	var items = {"Graviton Beam Emitter":[1,"-hp","-hp","-hp","atk","atk","atk","atk","atk","atk","atk","atk","atk","atk","atk","atk","atk","atk","atk","atk","atk","atk","atk","atk"]}
	var itemsprice = {"Graviton Beam Emitter":10000}
	$menu/label.text = "Smithy"
	var sale =load("res://spellbutton.tscn")
	for item in items.keys():
		var itembuttonnew = sale.instantiate()
		$"menu/buttons".add_child(itembuttonnew)
		itembuttonnew.text = item + ": "+str(itemsprice[item])+"g"
		itembuttonnew.pressed.connect(buyequipment.bind(items[item],item,itemsprice[item]))
		
func _on_generalstore_button_down() -> void:
	$menu.show()
	$dialouge.text = "Goods Trader Will:"+"\n"+"Only the most exotic and pristine goods here!"
	var items = {"Dragon Fruit":{"hp":100,"effects":[],"buffs":[],"price":400,"special":[],"target":"You","desc":"Heals 100 Hp","amount":1},"Melon":{"hp":20,"effects":[],"buffs":["def","def"],"price":100,"special":[],"target":"You","desc":"Raises defense and provides a light snack","amount":1},"Saffron":{"hp":15,"effects":[],"buffs":["mgc","mgc","mgc","mgc","mgc","mgc","mgc","mgc","mgc","mgc"],"price":1000,"special":[],"target":"You","desc":"Increases magical ability","amount":1},"Durian":{"hp":-20,"effects":[],"buffs":["def","def"],"price":70,"special":[],"target":"You","desc":"Spiky but hearty","amount":1}}
	$menu/label.text = "General Goods"
	var sale =load("res://spellbutton.tscn")
	for item in items.keys():
		var itembuttonnew = sale.instantiate()
		
		$"menu/buttons".add_child(itembuttonnew)
		itembuttonnew.text = item + ": "+str(items[item]["price"])+"g"
		itembuttonnew.pressed.connect(buyitem.bind(items[item],item,items[item]["price"]))




func _on_townhall_button_down() -> void:
	$menu.show()
	$dialouge.text = "Who would you like to talk to?"
	var items = {"Mayor Amanda":["Welcome, my friend, to our wonderful town","We have all sorts of exotic goods here, so feel free to look around"],"Handler Reginald":["Job pays well...","But thats about it","Mayor runs ths town, and he's kinda a jerk"],"Captian Alvin":["Aparently the keeper of the lighthouse up North went kookoo","We cant operate the ferry without it","Our stocks have been running on fumes, but to be honest, no one buys this stuff anyway"]}
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
	$dialouge.text = "Innkeeper Phil:"+"\n"+"15 gold for a room, finest in the land"
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
	$dialouge.text = "Pastor Andy:"+"\n"+"Welcome traveller, to the Church of Paint."
	$menu/label.text = "Church of Paint"
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
		var hp1 = [2000]
		$"../arena".enemies = {}
		$"../arena".enemiesstats = {}
		$"../arena".enemiesstatus = {}
		$"../arena".enemiesstatslvl = {}
		$"../arena".enemyhp = {}
		$"../arena".stolen = commongoods[itemstolen]["price"]*3
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

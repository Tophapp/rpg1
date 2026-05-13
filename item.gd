extends Area2D

@export var item = []
@export var itemtype = 1 #1 = item, 2= equipment, 3 = gold
var done = false

func _process(delta: float) -> void:
	if done == true:
		self.queue_free()
	
func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		if itemtype == 1:
			if not item[0] in $"../../arena".inventory.keys():
				$"../../arena".inventory[item[0]] = item[1]
				$"../../characters/player".popup("You have found a " +str(item[0]))
			else:
				$"../../arena".inventory[item[0]]["amount"] += item[1]["amount"]
				$"../../characters/player".popup("You have found a " +str(item[0]))
		elif itemtype == 2:
			if item[0] in $"../../arena".equipmentinventory:
				$"../../arena".equipmentinventory[item[0]][0] += 1
			else:
				$"../../arena".equipmentinventory[item[0]] = item[1]
			$"../../characters/player".popup("You have found a " +str(item[0]))
		elif itemtype == 3:
			$"../../arena".gold += item[0]
			$"../../characters/player".popup("You have found "+str(item[0])+"g")
		
		$"../../arena".forced.append(get_path())
		
		done = true
		
func _ready() -> void:
	connect("body_entered",_on_body_entered)

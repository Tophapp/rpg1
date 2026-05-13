extends Area2D

@export var enemycount =0
@export var level = []
@export var generatedenemy = []
@export var namenemy = []
@export var hp1 = []
@export var reward = {}
var done = false

	
func _process(delta: float) -> void:
	if done == true:
		self.queue_free()
	
var player_in_range = false
@export var text = ""


func _ready() -> void:
	connect("body_exited",_on_interaction_area_body_exited)
	connect("body_entered",_on_interaction_area_body_entered)
	
func _on_interaction_area_body_entered(body):
	if body.name == "player": # Or check for a specific group/type
		player_in_range = true
		

func _on_interaction_area_body_exited(body):
	if body.name == "player":
		player_in_range = false
		

func _input(event):
	
	if player_in_range and $"../../arena".visible == false and $"../../arena".battling == false:
		
		$"../../arena".enemies = {}
		$"../../arena".enemiesstats = {}
		$"../../arena".enemiesstatus = {}
		$"../../arena".enemiesstatslvl = {}
		$"../../arena".enemyhp = {}
		if reward != {null:null}:
			$"../../arena".reward = reward
		$"../../arena".boss = true
		
		$"../../arena".forcedbool = self.get_path()
		for creature in range(enemycount):
			$"../../arena".enemies[generatedenemy[creature]] = namenemy[creature]
			$"../../arena".enemyhp[generatedenemy[creature]]=hp1[creature]
			$"../../arena".enemiesstats[generatedenemy[creature]] = hp1[creature]
			$"../../arena".enemiesstatus[generatedenemy[creature]] = []
			$"../../arena".enemiesstatslvl[generatedenemy[creature]] = level[creature]
		$"../../arena".start()
		$"../../characters/player".popup(text)

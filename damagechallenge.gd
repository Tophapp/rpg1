extends Area2D

@export var enemycount =0
@export var level = []
@export var generatedenemy = []
@export var namenemy = []
@export var hp1 = []
@export var goal = 0
var done = false

func _ready() -> void:
	connect("body_entered",_on_body_entered)
	
func _process(delta: float) -> void:
	if done == true:
		self.queue_free()
	
func _on_body_entered(body: Node2D) -> void:
	if body.name == "player":
		$"../../../../arena".enemies = {}
		$"../../../../arena".enemiesstats = {}
		$"../../../../arena".enemiesstatus = {}
		$"../../../../arena".enemiesstatslvl = {}
		$"../../../../arena".enemyhp = {}
		$"../../../../arena".damagegoal = goal
		$"../../../../arena".forcedbool = self.get_path()
		for creature in range(enemycount):
			$"../../../../arena".enemies[generatedenemy[creature]] = namenemy[creature]
			$"../../../../arena".enemyhp[generatedenemy[creature]]=hp1[creature]
			$"../../../../arena".enemiesstats[generatedenemy[creature]] = hp1[creature]
			$"../../../../arena".enemiesstatus[generatedenemy[creature]] = []
			$"../../../../arena".enemiesstatslvl[generatedenemy[creature]] = level[creature]
		$"../../../../arena".start()

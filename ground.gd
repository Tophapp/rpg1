@tool
extends TileMapLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var scale2=7
	z_index=int(name)
	modulate = Color8(abs(255-int(name)*scale2),abs(255-int(name)*scale2),abs(255-int(name)*scale2))

extends "res://scripts/power_up.gd"

func _ready():
	connect("area_entered", self, "_on_area_entered")
	pass

func _on_area_entered(objeto):
	if objeto.is_in_group("ship"):
		objeto.vida += 1
		audio_player.play("power_up")
		queue_free()
	pass

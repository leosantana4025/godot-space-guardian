extends "res://scripts/laser.gd"

func _ready():
	connect("area_entered", self, "_on_area_entered")
	audio_player.play("laser_nave")
	pass

func _on_area_entered(objeto):
	if objeto.is_in_group("enemy"):
		objeto.vida -= 1
		emitir_brilho()
		utils.acionar_node("camera", "shake", 1, 0.13)
		queue_free()
		pass

extends Area2D

export var velocidade = Vector2()

const scene_brilho_laser = preload("res://scenes/brilho_laser.tscn")

func _ready():
	emitir_brilho()
	yield($visibility_notifier, "screen_exited")
	queue_free()
	pass

func _process(delta):
	translate(velocidade * delta)
	pass

func emitir_brilho():
	var brilho = scene_brilho_laser.instance()
	brilho.position = self.position
	utils.node_principal.add_child(brilho)
	pass

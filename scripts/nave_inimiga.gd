extends "res://scripts/inimigo.gd"

const scene_laser = preload("res://scenes/laser_inimigo.tscn")

func _ready():
	velocidade.x = utils.escolher([+velocidade.x, -velocidade.x])
	yield(utils.criar_tempo_espera(1), "timeout")
	disparar_laser()
	pass

func _process(delta):
	if self.position.x <= 0 + 16:
		velocidade.x = abs(velocidade.x)
		
	if self.position.x >= utils.tamanho_tela.x - 16:
		velocidade.x = -abs(velocidade.x)
	pass

func disparar_laser():
	while true:
		var laser = scene_laser.instance()
		laser.position = $canhao.global_position
		utils.node_principal.add_child(laser)
		yield(get_tree().create_timer(1.5), "timeout")
	pass

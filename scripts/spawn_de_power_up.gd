extends Node

const power_ups = [
	preload("res://scenes/power_up_vida.tscn"),
	preload("res://scenes/power_up_laser.tscn")
]

func _ready():
	yield(utils.criar_tempo_espera(rand_range(10, 15)), "timeout")
	spawn_power_up()
	pass

func spawn_power_up():
	while true:
		randomize()

		var inimigo = utils.escolher(power_ups).instance()
		var posicao_inimigo = Vector2()
		posicao_inimigo.x = rand_range(0 + 7, utils.tamanho_tela.x - 7)
		posicao_inimigo.y = 0 - 7
		inimigo.position = posicao_inimigo
		$container.add_child(inimigo)
		yield(utils.criar_tempo_espera(rand_range(10, 15)), "timeout")
	pass

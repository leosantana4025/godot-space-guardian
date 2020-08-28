extends Node

const inimigos = [
	preload("res://scenes/meteoro.tscn"),
	preload("res://scenes/nave_inimiga.tscn")
]

func _ready():
	yield(utils.criar_tempo_espera(1.2), "timeout")
	spawn_inimigo()
	pass

func spawn_inimigo():
	while true:
		randomize()
		var inimigo = utils.escolher(inimigos).instance()
		var posicao_inimigo = Vector2()
		
		posicao_inimigo.x = rand_range(0 + 16, utils.tamanho_tela.x - 16)
		posicao_inimigo.y = 0 - 16
		
		inimigo.position = posicao_inimigo
		
		$container.add_child(inimigo)
		yield(utils.criar_tempo_espera(rand_range(0.5, 1.25)), "timeout")
	pass

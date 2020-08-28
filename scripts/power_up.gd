extends Area2D

var velocidade = Vector2(0, 200)

func _ready():
	pass

func _process(delta):
	translate(velocidade * delta)
	
	if position.y >= utils.tamanho_tela.y + 7:
		queue_free()
	pass

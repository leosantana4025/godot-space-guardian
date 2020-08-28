extends Sprite

export var velocidade = Vector2()

func _ready():
	pass

func _process(delta):
	translate(velocidade * delta)
	
	if position.y >= utils.tamanho_tela.y:
		position = Vector2(0, -180)
	pass

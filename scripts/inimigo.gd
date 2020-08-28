extends Area2D

export var vida = 2 setget set_vida
export var valor_score = 5
export var velocidade = Vector2()

const scene_explosao = preload("res://scenes/explosao.tscn")

func _ready():
	add_to_group("enemy")
	connect("area_entered", self, "_on_area_entered")
	pass

func _process(delta):
	translate(velocidade * delta)
	if position.y - 16 >= utils.tamanho_tela.y:
		queue_free()
	pass

func _on_area_entered(objeto):
	if objeto.is_in_group("ship"):
		objeto.vida -= 1
		criar_explosao()
		queue_free()
	pass

func set_vida(novo_valor):
	if is_queued_for_deletion(): return
	
	if novo_valor < vida: audio_player.play("hit_nave_inimiga")
	vida = novo_valor
	
	if vida <= 0:
		utils.procurar_node("imagem_melhor_placar").score += valor_score
		criar_explosao()
		queue_free()
	pass

func criar_explosao():
	var explosao = scene_explosao.instance()
	explosao.position = self.position
	utils.node_principal.add_child(explosao)
	pass

extends Area2D

var vida = 4 setget set_vida
var is_tiro_duplo = false setget set_tiro_duplo

onready var nave_animada := $nave_animada

const scene_laser = preload("res://scenes/laser_nave.tscn")
const scene_explosao = preload("res://scenes/explosao.tscn")
const scene_flash = preload("res://scenes/flash.tscn")

export var velocidade_nave: float = 100
var velocidade := Vector2(0, 0)

signal vida_alterou

func _ready():
	add_to_group("ship")
	yield(utils.criar_tempo_espera(0.5), "timeout")
	disparar_laser()
	pass

func _process(delta):
	if velocidade.x < 0:
		nave_animada.play("esquerda")
	
	elif velocidade.x > 0:
		nave_animada.play("direita")
		
	else:
		nave_animada.play("frente")
	
	#Escondendo o cursor do mouse durante o gameplay
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)	
	
	#Limitando a nave a ficar dentro da resolução
	var viewport_rect = get_viewport_rect()
	position.x = clamp(position.x, 0, viewport_rect.size.x)
	position.y = clamp(position.y, 0, viewport_rect.size.y)
	pass

func _physics_process(delta):
	var direcao := Vector2(0, 0)
	
	if Input.is_action_pressed("esquerda"):
		direcao.x = -1
	
	elif Input.is_action_pressed("direita"):
		direcao.x = 1
	
	if Input.is_action_pressed("cima"):
		direcao.y = -1
	
	elif Input.is_action_pressed("baixo"):
		direcao.y = 1
	
	velocidade = direcao.normalized() * velocidade_nave
	position += velocidade * delta

func disparar_laser():
	while true:
		criar_laser($canhoes/canhao_esquerdo.global_position)
		criar_laser($canhoes/canhao_direito.global_position)
		
		if is_tiro_duplo:
			criar_laser($canhoes/canhao_esquerdo.global_position).velocidade.x = -25
			criar_laser($canhoes/canhao_direito.global_position).velocidade.x = +25
		
		yield(utils.criar_tempo_espera(0.25), "timeout")
	pass

func set_vida(novo_valor):
	if novo_valor > 4: return
	if novo_valor < vida:
		audio_player.play("hit_nave")
		utils.node_principal.add_child(scene_flash.instance())
	
	vida = novo_valor
	emit_signal("vida_alterou", vida)
	
	if vida <= 0:
		criar_explosao()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		queue_free()
	pass

func set_tiro_duplo(novo_valor):
	is_tiro_duplo = novo_valor
	
	if is_tiro_duplo:
		yield(utils.criar_tempo_espera(5), "timeout")
		is_tiro_duplo = false
	pass

func criar_laser(posicao):
	var laser = scene_laser.instance()
	laser.position = posicao
	utils.node_principal.add_child(laser)
	return laser
	pass

func criar_explosao():
	var explosao = scene_explosao.instance()
	explosao.position = self.position
	utils.node_principal.add_child(explosao)
	pass

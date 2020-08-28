extends Node

var node_principal setget, _get_node_principal
var tamanho_tela setget, _get_tamanho_tela
var posicao_mouse setget, _get_posicao_mouse

func _ready():
	pass

func criar_tempo_espera(tempo_espera):
	var timer = Timer.new()
	timer.set_wait_time(tempo_espera)
	timer.set_one_shot(true)
	timer.connect("timeout", timer, "queue_free")
	add_child(timer)
	timer.start()
	return timer
	pass

func escolher(escolhas):
	randomize()
	var rand_index = randi() % escolhas.size()
	return escolhas[rand_index]
	pass

func procurar_node(node):
	return self.node_principal.find_node(node)
	pass

func attach(source_node, source_signal, target_node, target_function):
	if typeof(source_node) == TYPE_STRING:
		source_node = procurar_node(source_node)
	
	if typeof(target_node) == TYPE_STRING:
		target_node = procurar_node(target_node)
	
	if source_node != null and target_node != null:
		source_node.connect(source_signal, target_node, target_function)
	pass

func acionar_node(source_node, metodo, argumento_0 = null, argumento_1 = null):
	source_node = procurar_node(source_node)
	
	if source_node and source_node.has_method(metodo):
		if argumento_0 and argumento_1:
			return source_node.call(metodo, argumento_0, argumento_1)
		
		if argumento_0:
			return source_node.call(metodo, argumento_0)
		
		return source_node.call(metodo)
	pass

func _get_posicao_mouse():
	return get_viewport().get_mouse_position()
	pass

func _get_node_principal():
	var raiz = get_tree().get_root()
	return raiz.get_child(raiz.get_child_count() - 1)
	pass

func _get_tamanho_tela():
	return get_tree().get_root().get_visible_rect().size
	pass

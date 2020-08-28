extends Node

var melhor_placar = 0 setget set_melhor_placar
const caminho_arquivo = "user://melhor_placar.dat"

func _ready():
	carregar_save()
	pass

func carregar_save():
	var arquivo = File.new()
	if not arquivo.file_exists(caminho_arquivo): return
	arquivo.open(caminho_arquivo, File.READ)
	melhor_placar = arquivo.get_var()
	arquivo.close()
	pass

func salvar_melhor_placar():
	var arquivo = File.new()
	arquivo.open(caminho_arquivo, File.WRITE)
	arquivo.store_var(melhor_placar)
	arquivo.close()
	pass

func set_melhor_placar(valor):
	melhor_placar = valor
	salvar_melhor_placar()
	pass

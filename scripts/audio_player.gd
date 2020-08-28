extends Node

func _ready():
	pass

func play(nome):
	var player = AudioStreamPlayer.new()
	player.stream = $carrega_musica.get_resource(nome)
	player.connect("finished", player, "queue_free")
	player.play()
	add_child(player)
	pass

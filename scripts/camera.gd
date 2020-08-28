extends Camera2D

var magnitude = 0
var tempo_restante = 0
var is_movendo = false

func _ready():
	pass

func shake(nova_magnitude, life_time):
	if magnitude > nova_magnitude: return
	
	magnitude = nova_magnitude
	tempo_restante = life_time
	
	if is_movendo: return
	is_movendo = true
	
	while tempo_restante > 0:
		position.x = rand_range(-magnitude, +magnitude)
		position.y = rand_range(-magnitude, +magnitude)
		
		tempo_restante -= get_process_delta_time()
		yield(get_tree(), "idle_frame")
	
	magnitude = 0
	is_movendo = false
	position = Vector2.ZERO
	pass

extends Node2D

@export var sampah : Array[PackedScene]

@export var spawnersize = 300

func _ready() -> void:
	pass

func spawnwarga(jumlah):
	for i in range(jumlah):
		var randlocation = Vector2(
			randf_range(position.x-spawnersize,position.x+spawnersize),
			randf_range(position.y-spawnersize,position.y+spawnersize)
		)
		var sampahinstance = sampah.pick_random().instantiate()
		sampahinstance.position = randlocation
		sampahinstance.z_index = i
		get_parent().add_child.call_deferred(sampahinstance)

func _on_timer_timeout() -> void:
	spawnwarga(1)

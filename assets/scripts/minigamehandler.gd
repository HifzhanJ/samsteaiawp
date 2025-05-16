extends Node

func _ready() -> void:
	Dialogic.timeline_ended.connect(_on_timeline_ended)

func _on_timeline_ended():
	for child in get_children():
		child.queue_free()
	Dialogic.paused=false

func minigamestart():
	get_tree().change_scene_to_file("res://assets/scenes/minigames.tscn")

func playslashbakteri():
	Dialogic.paused = true
	add_child(load("res://assets/scenes/Minigames/slashabakteri/slashbakteri.tscn").instantiate())

func playkumpulsampah():
	Dialogic.paused = true
	add_child(load("res://assets/scenes/Minigames/kumpulsampah/kumpulsampah.tscn").instantiate())

func playtaptapwarga():
	Dialogic.paused = true
	add_child(load("res://assets/scenes/Minigames/taptapwarga/taptapwarga.tscn").instantiate())

func playslashbosbakteri():
	Dialogic.paused = true
	add_child(load("res://assets/scenes/Minigames/bosbakteri/slashbosbakteri.tscn").instantiate())

func playpipa():
	Dialogic.paused = true
	add_child(load("res://assets/scenes/Minigames/ubahpipa/ubahpipa.tscn").instantiate())

func slashbakterimenang():
	get_node("slashbakteri").queue_free()
	visualnovel()
	Dialogic.paused = false

func slashbosbakterimenang():
	get_node("slashbosbakteri").queue_free()
	visualnovel()
	Dialogic.paused = false

func kumpulsampahmenang():
	get_node("kumpulsampah").queue_free()
	visualnovel()
	Dialogic.paused = false

func taptapwargamenang():
	get_node("taptapwarga").queue_free()
	visualnovel()
	Dialogic.paused = false

func pipamenang():
	get_node("ubahpipa").queue_free()
	visualnovel()
	Dialogic.paused = false

func visualnovel():
	get_tree().change_scene_to_file("res://assets/scenes/VisualNovel.tscn")

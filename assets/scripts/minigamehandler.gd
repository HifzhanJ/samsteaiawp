extends Node

func minigamestart():
	get_node("/root/VisualNovel").hide()
	get_tree().change_scene_to_file("res://assets/scenes/minigames.tscn")
	
func playslashbakteri():
	Dialogic.end_timeline()
	add_child(load("res://assets/scenes/Minigames/slashabakteri/slashbakteri.tscn").instantiate())

func playkumpulsampah():
	Dialogic.end_timeline()
	add_child(load("res://assets/scenes/Minigames/kumpulsampah/kumpulsampah.tscn").instantiate())

func playtaptapwarga():
	Dialogic.end_timeline()
	add_child(load("res://assets/scenes/Minigames/taptapwarga/taptapwarga.tscn").instantiate())

func playpipa():
	Dialogic.end_timeline()
	add_child(load("res://assets/scenes/Minigames/ubahpipa/ubahpipa.tscn").instantiate())

func slashbakterimenang():
	get_node("slashbakteri").queue_free()
	visualnovel()
	Dialogic.start("chapter2","Minigame Selesai [Slash Bakteri]")

func kumpulsampahmenang():
	get_node("kumpulsampah").queue_free()
	visualnovel()
	Dialogic.start("chapter2","Minigame Keluar [Kumpul Sampah]")

func taptapwargamenang():
	get_node("taptapwarga").queue_free()
	visualnovel()
	Dialogic.start("chapter2","Minigames Selesai [Tap - tap warga]")

func pipamenang():
	pass

func visualnovel():
	get_tree().change_scene_to_file("res://assets/scenes/VisualNovel.tscn")

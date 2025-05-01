extends Button

func _on_pressed() -> void:
	if Dialogic.Save.has_slot(name):
		Dialogic.Save.load(name)
		get_tree().change_scene_to_file("res://assets/scenes/VisualNovel.tscn")

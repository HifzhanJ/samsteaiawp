extends Control

func _on_lanjut_pressed() -> void:
	$AudioManager.playbuttonclick()

func _on_mulai_pressed() -> void:
	$AudioManager.playbuttonclick()
	get_tree().change_scene_to_file("res://assets/scenes/VisualNovel.tscn")
	Dialogic.start("prolog")

func _on_muat_pressed() -> void:
	$AudioManager.playbuttonclick()
	$LoadPanel.openPanel()

func _on_pengaturan_pressed() -> void:
	$AudioManager.playbuttonclick()
	$Setting.show()

func _on_keluar_pressed() -> void:
	$AudioManager.playbuttonclick()
	get_tree().quit()

func _on_lanjut_mouse_entered() -> void:
	$AudioManager.playbuttonhover()

func _on_mulai_mouse_entered() -> void:
	$AudioManager.playbuttonhover()

func _on_muat_mouse_entered() -> void:
	$AudioManager.playbuttonhover()

func _on_pengaturan_mouse_entered() -> void:
	$AudioManager.playbuttonhover()

func _on_keluar_mouse_entered() -> void:
	$AudioManager.playbuttonhover()

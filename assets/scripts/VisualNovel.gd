extends CanvasLayer

func _on_setting_pressed() -> void:
	$AudioManager.playbuttonclick()
	$Setting.show()

func _on_save_pressed() -> void:
	$AudioManager.playbuttonclick()
	$SavePanel.openPanel()

func _on_load_pressed() -> void:
	$AudioManager.playbuttonclick()
	$LoadPanel.openPanel()

func _on_exit_pressed() -> void:
	get_tree().quit()

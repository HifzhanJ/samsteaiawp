extends CanvasLayer

func _ready():
	if Dialogic.event_handled.is_connected(_on_dialogic_text):
		Dialogic.event_handled.disconnect(_on_dialogic_text)
	Dialogic.event_handled.connect(_on_dialogic_text)

func _on_dialogic_text(event):
	if event is DialogicTextEvent:
		print("dialogic text signal")
		var character_name = event.character.display_name if event.character else "-"
		$chathistoryui/chathistory.add_to_history(character_name, event.text)

func _on_dialogic_signal(argument:String):
	print("signal")
	if argument == "taptapbakteri":
		get_tree().change_scene_to_file("res://assets/scenes/taptapbakteri.tscn")
		print("Something was activated!")

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
	Dialogic.end_timeline()
	get_tree().change_scene_to_file("res://assets/scenes/MainMenu.tscn")

func _on_history_pressed() -> void:
	$chathistoryui.display_history()

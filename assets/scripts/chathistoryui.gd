extends Panel

func display_history():
	$MarginContainer/TextEdit.text = ""
	show()
	var history = $chathistory.get_history()
	for entry in history:
		$MarginContainer/TextEdit.text = $MarginContainer/TextEdit.text + entry.character + " : " + entry.text + "\n"

func hide_history():
	hide()

func _on_back_pressed() -> void:
	hide_history()

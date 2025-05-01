extends Panel

func _on_back_button_pressed() -> void:
	hide()

func openPanel():
	show()
	for slot in $MarginContainer/VBoxContainer/HBoxContainer.get_children():
		slot.get_node("MarginContainer/TextureRect").texture = Dialogic.Save.get_slot_thumbnail(slot.name)
		var slot_info_dictionary := Dialogic.Save.get_slot_info(slot.name)
		var date: String = slot_info_dictionary.get("date", "")
		slot.get_node("MarginContainer/Date").text = date
		slot.text = slot.name

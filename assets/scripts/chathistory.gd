extends Node

var chat_history = []

func add_to_history(character: String, text: String):
	var display_name = Dialogic.VAR.get_variable("namauser")
	var processed_display_name = character.replace("{namauser}", display_name)
	var processed_text = text.replace("{namauser}", display_name)
	chat_history.append({"character": processed_display_name, "text": processed_text})

func get_history():
	return chat_history.duplicate()

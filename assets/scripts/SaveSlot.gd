extends Button

func _on_pressed() -> void:
	var extra_info := {}
	extra_info["date"] = Time.get_datetime_string_from_system(false, true)
	Dialogic.Save.save(name,false,Dialogic.Save.ThumbnailMode.TAKE_AND_STORE,extra_info)
	Dialogic.History.save_visited_history()
	$"../../../../".openPanel()

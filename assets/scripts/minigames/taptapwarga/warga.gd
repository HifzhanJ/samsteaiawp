extends Area2D

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.is_pressed():
		ingatkan()

func ingatkan():
	get_parent().addscore(1)
	queue_free()

func _on_lari_timeout() -> void:
	tangkap()

func tangkap():
	queue_free()

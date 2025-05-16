extends Area2D

@export_enum("organik", "anorganik", "b3") 
var jenis: String
var mouseentered = false
var dragging: bool = false

func get_jenis() -> String:
	return jenis

func _input(event: InputEvent) -> void:
	print("test")

func _unhandled_input(event: InputEvent) -> void:
	print("test")
	if event is InputEventMouseButton and mouseentered:
		dragging = event.button_index == MOUSE_BUTTON_LEFT and event.pressed
		get_viewport().set_input_as_handled()

func _process(delta: float) -> void:
	if dragging:
		global_position = get_global_mouse_position()

func _on_mouse_entered() -> void:
	mouseentered = true

func _on_mouse_exited() -> void:
	mouseentered = false

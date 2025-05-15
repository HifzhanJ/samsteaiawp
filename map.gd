extends Control

const SCROLL_SENSITIVITY = .005
@onready var scroll_container = $MarginContainer/HBoxContainer
var mouse_button_down = false

func _gui_input(event: InputEvent) -> void:
	if (event is InputEventMouseButton):
		if (event.button_index == MOUSE_BUTTON_LEFT):
			mouse_button_down = event.pressed
	
	# Scroll with the mouse
	if (event is InputEventMouseMotion and mouse_button_down == true):
		print(event.velocity)
		scroll_container.scroll_horizontal -= event.velocity.x*SCROLL_SENSITIVITY

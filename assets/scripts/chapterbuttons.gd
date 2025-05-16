extends Button

@export var timeline:String = ""

func _ready() -> void:
	text = " "+text+" "

func _on_mouse_entered() -> void:
	$hover.play()

func _on_pressed() -> void:
	$hit.play()
	await $hit.finished
	Dialogic.paused = false
	Dialogic.start(timeline)
	get_tree().change_scene_to_file("res://assets/scenes/VisualNovel.tscn")

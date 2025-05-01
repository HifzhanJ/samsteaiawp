extends Panel

func _ready() -> void:
	$anim.play("In")
	await $anim.animation_finished
	get_tree().change_scene_to_file("res://assets/scenes/MainMenu.tscn")

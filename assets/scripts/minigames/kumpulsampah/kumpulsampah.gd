extends Node2D

var score = 0
@export var targetscore = 10

func _ready() -> void:
	$CanvasLayer/Control.set_mouse_filter(Control.MOUSE_FILTER_IGNORE)

func addscore(newscore):
	score+=newscore
	updatescore()
	if score>=targetscore:
		get_parent().kumpulsampahmenang()
		$CanvasLayer/Control/Menang.show()

func updatescore():
	%score.text = "Score : "+str(score)

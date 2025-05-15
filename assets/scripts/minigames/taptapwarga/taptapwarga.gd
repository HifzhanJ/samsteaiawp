extends Node2D

@export var targetscore = 20
var score = 0

func _ready() -> void:
	$CanvasLayer/Control.set_mouse_filter(Control.MOUSE_FILTER_IGNORE)

func addscore(newscore):
	score+=newscore
	updatescore()
	if score>=targetscore:
		get_parent().taptapwargamenang()

func updatescore():
	%score.text = "Score : "+str(score)

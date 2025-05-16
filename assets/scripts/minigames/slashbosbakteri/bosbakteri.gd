extends Area2D

@onready var anim = $anim
@onready var hitsfx = $hit
var juice = preload("res://assets/scenes/bacteriajuice.tscn")
var HEALTH = 500

func _ready() -> void:
	$healthbar.value = HEALTH
	$GPUParticles2D.emitting=true

func damage(dp):
	HEALTH-=dp
	$healthbar.value = HEALTH
	hitsfx.play()
	var juiceinstance = juice.instantiate()
	juiceinstance.position = position
	juiceinstance.rotation = deg_to_rad(randf_range(-360,360))
	get_node("../../juice").add_child(juiceinstance)
	anim.play("hit")
	await anim.animation_finished
	anim.play("RESET")
	if HEALTH <= 0:
		get_node("../../").addscore(1)
		queue_free()

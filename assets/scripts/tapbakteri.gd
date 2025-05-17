extends Node2D

var score = 0

var bakteri = preload("res://assets/scenes/Enemy/bakteri.tscn")
@onready var enemynode = $enemy
@onready var summonpoint = $summonpoint
@onready var slash_line = $slash
@export var targetscore = 30
var summonsize = 300

func _ready() -> void:
	$CanvasLayer/Control.set_mouse_filter(Control.MOUSE_FILTER_IGNORE)
	

func spawnbakteri(jumlah):
	var bakteriinstance = bakteri.instantiate()
	var posisi = Vector2(
		randf_range(summonpoint.global_position.x-summonsize,summonpoint.global_position.x+summonsize),
		randf_range(summonpoint.global_position.y-summonsize,summonpoint.global_position.y+summonsize)
	)
	
	bakteriinstance.position = posisi
	bakteriinstance.rotation = deg_to_rad(randf_range(-360,360))
	enemynode.add_child(bakteriinstance)

func _on_timer_timeout() -> void:
	spawnbakteri(1)

func addscore(newscore):
	score+=newscore
	updatescore()
	if score>=targetscore:
		get_parent().slashbakterimenang()
		print("menang")

func updatescore():
	%score.text = "Score : "+str(score)

var slash_path = [] # Store the points of the slash
var is_slashing = false
var pointlifetime = 0.3

@export var slashsfx :Array[AudioStream]

func _input(event):
	if event is InputEventMouseMotion:
		if Input.is_action_pressed("LeftMouse"):  # "ui_accept" maps to left-click/touch
			is_slashing = true
			if not $slashsfx.playing:
				$slashsfx.stream = slashsfx.pick_random()
				$slashsfx.play()
			slash_path.append({"position": event.position, "time": Time.get_ticks_msec()})  # Add the position to the path
			check_slash_hit(event.position)
		else:
			is_slashing = false
			slash_path.clear()  # Clear the path when the user stops slashing
	elif event is InputEventScreenTouch and event.pressed:
		is_slashing = true
		slash_path.append({"position": event.position, "time": Time.get_ticks_msec()})
		check_slash_hit(event.position)
	elif event is InputEventScreenTouch and not event.pressed:
		is_slashing = false
		slash_path.clear()

func _process(delta):
	if is_slashing:
				# Remove points older than their lifetime
		var current_time = Time.get_ticks_msec()
		for i in range(slash_path.size() - 1, -1, -1):
			if (current_time - slash_path[i].time) > pointlifetime * 1000:
				slash_path.remove_at(i)
		# Update Line2D with only the remaining points
		var current_points = []
		for point in slash_path:
			current_points.append(point.position)
		slash_line.points = current_points  # Update the Line2D points
	else:
		slash_line.points = []  # Clear the Line2D

var dp = 20

func check_slash_hit(position):
	# Get all objects in the slash area
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsPointQueryParameters2D.new()
	query.position = position
	query.collide_with_areas = true # Or false if using collision shapes
	query.collide_with_bodies = true
	
	var results = space_state.intersect_point(query)
	for result in results:
		var collider = result.collider
		# Check if the collider has a damage method
		if collider.has_method("damage"):
			collider.damage(dp)

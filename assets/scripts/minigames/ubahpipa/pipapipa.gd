extends Node2D

@export var pipa : Array[PackedScene]
@export var batu : PackedScene
@export var tanah : PackedScene
@export var gridsize : Vector2i
@export var posisipipabaru : Vector2

var rotasipipa = []

var astargrid = AStarGrid2D.new()
var startid
var endid

func generateastar():
	astargrid.size = gridsize
	astargrid.cell_size = Vector2i(128,128)
	astargrid.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astargrid.update()
	generatelevel()

func get_random_angle_radians() -> float:
	var step = 90
	var range_count = int((360 * 2) / step) + 1
	var random_angle = (int(randi() % range_count) - int(360 / step)) * step
	return deg_to_rad(random_angle)

func generatepipa():
	generateastar()
	var posisipipa = self.position
	var pipepath = astargrid.get_id_path(startid,endid)
	print("Pipe path : "+str(pipepath))
	#gambar pipa
	for i in range(pipepath.size()):
		var idpath = pipepath[i]
		var pipainstance
		if should_be_bent_pipe(i, pipepath):
			pipainstance = pipa[1].instantiate()  # Pipa bengkok
		else:
			pipainstance = pipa[0].instantiate()  # Pipa lurus
		pipainstance.position = Vector2(posisipipa.x+(idpath.x*posisipipabaru.x),posisipipa.y+(idpath.y*posisipipabaru.y))
		pipainstance.rotation = determine_pipe_rotation(i, pipepath)
		rotasipipa.append(pipainstance.rotation)
		get_parent().add_child(pipainstance)
	print(rotasipipa)

	#gambar batu
	for i in range(astargrid.size.x):
		for j in range(astargrid.size.y):
			if astargrid.is_point_solid(Vector2i(i,j)):
				var batuinstance = batu.instantiate()
				batuinstance.position = Vector2(posisipipa.x+(i*posisipipabaru.x),posisipipa.y+(j*posisipipabaru.y))
				get_parent().add_child(batuinstance)
			else:
				if not Vector2i(i,j) in pipepath and Vector2i(i,j)!=startid and Vector2i(i,j)!=endid:
					var tanahinstance = tanah.instantiate()
					tanahinstance.position = Vector2(posisipipa.x+(i*posisipipabaru.x),posisipipa.y+(j*posisipipabaru.y))
					tanahinstance.get_node("text").text = str(Vector2(i,j))
					get_parent().add_child(tanahinstance)

func generatelevel():
	var start_side = randi() % 4
	startid = [
		Vector2i(randi_range(0, gridsize.x-1), 0),               # Top
		Vector2i(gridsize.x-1, randi_range(0, gridsize.y-1)),    # Right
		Vector2i(randi_range(0, gridsize.x-1), gridsize.y-1),    # Bottom
		Vector2i(0, randi_range(0, gridsize.y-1))                # Left
	][start_side]

	endid = [
		Vector2i(randi_range(0, gridsize.x-1), 0),               # Top
		Vector2i(gridsize.x-1, randi_range(0, gridsize.y-1)),    # Right
		Vector2i(randi_range(0, gridsize.x-1), gridsize.y-1),    # Bottom
		Vector2i(0, randi_range(0, gridsize.y-1))                # Left
	][(start_side + 1 + randi() % 3) % 4]
	
	var obstacleids = []
	var max_obstacle = randi_range(1,(gridsize.x+gridsize.y)/2)

	while obstacleids.size()<max_obstacle:
		var obstacleid = Vector2i(randi_range(0,gridsize.x-1),randi_range(0,gridsize.y-1))
		if obstacleid!=startid and obstacleid!=endid and not obstacleid in obstacleids:
			obstacleids.append(obstacleid)

	print("start id : "+str(startid))
	print("end id :"+str(endid))
	print("obstacle ids : "+str(obstacleids))
	
	for obstacleid in obstacleids:
		print("obstacle at " + str(obstacleid))
		astargrid.set_point_solid(obstacleid,true)
	astargrid.update()

	if not is_path_possible(startid,endid):
		return generatelevel()

func is_path_possible(start,end):
	var trypath = astargrid.get_id_path(start,end)
	return trypath.size() > 0
	
func should_be_bent_pipe(index, path):
	if index == 0 or index == path.size()-1:
		return false  # Pipa awal/akhir selalu lurus

	var prev_pos = path[index-1]
	var current_pos = path[index]
	var next_pos = path[index+1]

	# Pipa bengkok jika arah berubah (tidak lurus)
	var dir_in = current_pos - prev_pos
	var dir_out = next_pos - current_pos

	return dir_in != dir_out

func determine_pipe_rotation(index, path):
	if index == 0:  # Pipa awal
		var next_pos = path[index+1]
		var dir_out = next_pos - path[index]
		return direction_to_rotation(dir_out)
	elif index == path.size()-1:  # Pipa akhir
		var prev_pos = path[index-1]
		var dir_in = path[index] - prev_pos
		return direction_to_rotation(dir_in)
	else:  # Pipa tengah
		var prev_pos = path[index-1]
		var next_pos = path[index+1]
		var dir_in = path[index] - prev_pos
		var dir_out = next_pos - path[index]
		
		# Untuk pipa bengkok
		if dir_in != dir_out:
			return get_bend_rotation(dir_in, dir_out)
		# Untuk pipa lurus
		else:
			return direction_to_rotation(dir_in)


func direction_to_rotation(dir):
	if dir.x > 0: return 0      # Kanan (0 derajat)
	elif dir.x < 0: return PI    # Kiri (180 derajat)
	elif dir.y > 0: return PI/2  # Bawah (90 derajat)
	else: return 3*PI/2          # Atas (270 derajat)

func get_bend_rotation(dir_in, dir_out):
	# Gabungkan arah masuk dan keluar untuk menentukan rotasi belokan
	var combined = Vector2(dir_in.x + dir_out.x, dir_in.y + dir_out.y)

	if combined == Vector2(1,1): return 0      # Kanan-Bawah
	elif combined == Vector2(1,-1): return 3*PI/2  # Kanan-Atas
	elif combined == Vector2(-1,1): return PI/2    # Kiri-Bawah
	elif combined == Vector2(-1,-1): return PI     # Kiri-Atas
	return 0

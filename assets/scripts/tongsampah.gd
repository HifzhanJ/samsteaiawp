extends Area2D

@export_enum("organik","anorganik","b3") var jenis:String

var sampah

func _on_area_entered(area: Area2D) -> void:
	if area.has_method("get_jenis") and area.jenis == self.jenis:
		get_parent().addscore(1)
		area.queue_free()

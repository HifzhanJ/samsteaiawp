extends Panel

var MasterIdx = AudioServer.get_bus_index("Master")
var MusicIdx = AudioServer.get_bus_index("Music")
var SfxIdx = AudioServer.get_bus_index("SFX")

const DisplayMode = ["Full Screen","Windowed"]
const ResolutionDictionary = {
	"1920x1280":Vector2i(1920,1080),
	"1280x720":Vector2i(1280,720),
	"720x480":Vector2i(720,480)
}

func _ready() -> void:
	%VolumeMaster.value = db_to_linear(AudioServer.get_bus_volume_db(MasterIdx))
	print(%VolumeMaster.value)
	%VolumeMusik.value = db_to_linear(AudioServer.get_bus_volume_db(MusicIdx))
	%VolumeEfekSuara.value = db_to_linear(AudioServer.get_bus_volume_db(SfxIdx))

func _on_volume_master_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(MasterIdx,linear_to_db(value))
	print(%VolumeMaster.value)

func _on_volume_musik_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(MusicIdx,linear_to_db(value))

func _on_volume_efek_suara_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(SfxIdx,linear_to_db(value))

func _on_back_button_pressed() -> void:
	$"../AudioManager".playbuttonclick()
	hide()

func _on_display_mode_button_pressed() -> void:
	$"../AudioManager".playbuttonclick()

func _on_resolution_button_pressed() -> void:
	$"../AudioManager".playbuttonclick()

func _on_tab_container_tab_clicked(tab: int) -> void:
	$"../AudioManager".playbuttonclick()

func _on_display_mode_button_item_selected(index: int) -> void:
	$"../AudioManager".playbuttonclick()
	match index:
		0: # FullScreen
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		1: # Windowed
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_resolution_button_item_selected(index: int) -> void:
	$"../AudioManager".playbuttonclick()
	DisplayServer.window_set_size(ResolutionDictionary.values()[index])

extends Control

# Pastikan di Scene Tree namamu "SettingPanel" atau "SettingsPanel"
# Sesuaikan baris di bawah ini dengan nama asli di Scene Tree kamu
onready var settings_panel = $Popups/SettingPanel
onready var master_slider = $Popups/SettingPanel/MasterSlider
onready var info_panel = $Popups/InfoPanel

func _ready():
	MusicManager.play_menu_theme()
	
	if master_slider:
		var current_vol = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
		master_slider.value = db2linear(current_vol)
		
		if not master_slider.is_connected("value_changed", self, "_on_MasterSlider_value_changed"):
			master_slider.connect("value_changed", self, "_on_MasterSlider_value_changed")

# --- LOGIKA VOLUME ---
func _on_MasterSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear2db(value))

# --- LOGIKA POPUP SETTINGS ---
# Pastikan Tombol Setting dihubungkan ke SINI
func _on_BtnSetting_pressed():
	print("Membuka Pengaturan") # Untuk cek di debugger
	MusicManager.play_click()
	settings_panel.show()

# Pastikan Tombol Close di dalam Panel Setting dihubungkan ke SINI
func _on_BtnCloseSetting_pressed():
	MusicManager.play_click()
	settings_panel.hide()

# --- LOGIKA POPUP INFO ---
func _on_BtnInfo_pressed():
	print("Membuka Info")
	MusicManager.play_click()
	info_panel.show()

func _on_BtnCloseInfo_pressed():
	MusicManager.play_click()
	info_panel.hide()

# --- LOGIKA TOMBOL UTAMA ---
func _on_BtnPlay_pressed():
	MusicManager.play_click()
	get_tree().change_scene("res://scene/StageSelection.tscn")

func _on_BtnExit_pressed():
	MusicManager.play_click()
	yield(get_tree().create_timer(0.2), "timeout")
	get_tree().quit()

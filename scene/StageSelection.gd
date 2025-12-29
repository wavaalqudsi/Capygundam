extends Control

func _ready():
	# Hubungkan tombol kembali
	$BtnBack.connect("pressed", self, "_on_back_pressed")
	
	# Kita akan menghubungkan semua tombol stage yang ada di dalam GridContainer
	# Ini teknik efisien (looping) daripada menghubungkan satu-satu di editor
	for button in $GridContainer.get_children():
		button.connect("pressed", self, "_on_stage_pressed", [button.name])

func _on_back_pressed():
	MusicManager.play_click()
	# Kembali ke menu utama
	get_tree().change_scene("res://scene/MainMenu.tscn")

func _on_stage_pressed(stage_name):
	MusicManager.play_click()
	# Ambil angka dari nama tombol (misal "Stage1" jadi "1")
	# Sebagai mahasiswa informatika, kamu bisa menggunakan regex atau manipulasi string sederhana
	if stage_name == "Stage1":
		Global.current_stage = 1
		get_tree().change_scene("res://scene/InGame.tscn")
	elif stage_name == "Stage2":
		Global.current_stage = 2
	elif stage_name == "Stage3":
		Global.current_stage = 3
	
	# Pindah ke scene In-Game
	get_tree().change_scene("res://scene/InGame.tscn")

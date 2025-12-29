extends Control

var soal_sekarang 

func _ready():
	randomize() 
	tampilkan_soal_baru()
	MusicManager.play_battle_theme()

func tampilkan_soal_baru():
	if Global.questions.size() > 0:
		var index_acak = randi() % Global.questions.size()
		soal_sekarang = Global.questions[index_acak]
		
		$LabelSoal.text = soal_sekarang["tanya"]
		
		# PERBAIKAN INDEKS: Gunakan 0, 1, 2 (Informatika standard)
		$VBoxContainer/BtnOpsi1.text = soal_sekarang["opsi"][0]
		$VBoxContainer/BtnOpsi2.text = soal_sekarang["opsi"][1]
		$VBoxContainer/BtnOpsi3.text = soal_sekarang["opsi"][2]
		
		Global.questions.remove(index_acak)
	else:
		# Kembali ke InGame jika soal habis
		get_tree().change_scene("res://scene/InGame.tscn")

# Fungsi pemroses jawaban
func proses_pilihan(indeks_dipilih):
	if indeks_dipilih == soal_sekarang["jawaban"]:
		Global.player_dmg += 20
		print("Jawaban Benar!")
	else:
		Global.player_dmg = max(0, Global.player_dmg - 10)
		print("Jawaban Salah!")
	
	get_tree().change_scene("res://scene/InGame.tscn")

# Pastikan fungsi ini TIDAK memiliki parameter di dalam kurung ()
func _on_BtnOpsi1_pressed():
	MusicManager.play_click()
	proses_pilihan(0)

func _on_BtnOpsi2_pressed():
	MusicManager.play_click()
	proses_pilihan(1)

func _on_BtnOpsi3_pressed():
	MusicManager.play_click()
	proses_pilihan(2)

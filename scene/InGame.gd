extends Control

# --- DEKLARASI NODE ---
onready var log_box = $HBoxContainer/BattleSide/RichTextLabel
onready var player_sprite = $HBoxContainer/BattleSide/PlayerRobot
onready var enemy_sprite = $HBoxContainer/BattleSide/Enemy
onready var enemy_hp_bar = $HBoxContainer/BattleSide/EnemyHPBar
onready var player_hp_bar = $HBoxContainer/BattleSide/PlayerHPBar
onready var tween = $Tween
onready var win_menu = $UIOverlay/WinMenu
onready var lose_menu = $UIOverlay/LoseMenu
onready var sfx_player = $SFXPlayer

# --- PRELOAD AUDIO ---
var sound_attack = preload("res://asset/audio/attack-release-384909.mp3")
var sound_hit = preload("res://asset/audio/classic-punch-impact-352711.mp3")
var sound_win = preload("res://asset/audio/marble-it-up-ultra-soccer-win-sound-418896.mp3")
var sound_lose = preload("res://asset/audio/lose-sfx-365579.mp3")

func _ready():
	setup_enemy()
	update_ui()
	# Matikan musik menu, kita bisa ganti dengan BGM Battle di sini nanti=
	MusicManager.play_battle_theme()

func setup_enemy():
	var stage = Global.current_stage
	if Global.enemy_list.has(stage):
		var data = Global.enemy_list[stage]
		Global.enemy_name = data["name"]
		Global.enemy_hp = data["hp"]
		var tex = load(data["texture"])
		if tex: enemy_sprite.texture = tex
		enemy_hp_bar.max_value = data["hp"]
	else:
		Global.enemy_name = "Robot Elite Mk-" + str(stage)
		Global.enemy_hp = 100 + (stage * 50)
		enemy_hp_bar.max_value = Global.enemy_hp

	enemy_hp_bar.value = Global.enemy_hp
	$HBoxContainer/BattleSide/EnemyDMG.text = Global.enemy_name
	log_box.bbcode_text = "Stage " + str(stage) + ": " + Global.enemy_name

func update_ui():
	$HBoxContainer/ControlSide/VBoxContainer/LblPlayerHP.text = "HP: " + str(Global.player_hp)
	$HBoxContainer/ControlSide/VBoxContainer/LblPlayerDMG.text = "DMG: " + str(Global.player_dmg)
	player_hp_bar.value = Global.player_hp

# --- LOGIKA TURN BASED ---

func _on_BtnStartMatch_pressed():
	MusicManager.play_click()
	$HBoxContainer/ControlSide/VBoxContainer/BtnStartMatch.disabled = true
	$HBoxContainer/ControlSide/VBoxContainer/BtnAddDMG.disabled = true
	
	sfx_player.pitch_scale = rand_range(0.9, 1.1) 
	sfx_player.stream = sound_hit
	sfx_player.play()
	
	log_box.bbcode_text = "Robot Player menyerang!"
	
	# Suara Serangan Dimulai
	sfx_player.stream = sound_attack
	sfx_player.play()
	
	var pos_awal = player_sprite.position
	tween.interpolate_property(player_sprite, "position", pos_awal, pos_awal + Vector2(50, 0), 0.2, Tween.TRANS_SINE, Tween.EASE_OUT)
	tween.start()
	yield(tween, "tween_completed")
	
	# Robot sampai di musuh: Suara Pukulan & Kurangi HP
	sfx_player.stream = sound_hit
	sfx_player.play()
	Global.enemy_hp -= Global.player_dmg
	enemy_hp_bar.value = Global.enemy_hp
	
	tween.interpolate_property(player_sprite, "position", player_sprite.position, pos_awal, 0.2, Tween.TRANS_SINE, Tween.EASE_IN)
	tween.start()
	yield(tween, "tween_completed")
	
	if Global.enemy_hp <= 0:
		menang()
		return

	yield(get_tree().create_timer(1.0), "timeout")
	
	log_box.bbcode_text = "Musuh menyerang balik!"
	# Tambahkan suara serangan musuh di sini jika ada
	var pos_awal_enemy = enemy_sprite.position
	tween.interpolate_property(enemy_sprite, "position", pos_awal_enemy, pos_awal_enemy - Vector2(50, 0), 0.2, Tween.TRANS_SINE, Tween.EASE_OUT)
	tween.start()
	yield(tween, "tween_completed")
	
	Global.player_hp -= 10
	update_ui()
	
	tween.interpolate_property(enemy_sprite, "position", enemy_sprite.position, pos_awal_enemy, 0.2, Tween.TRANS_SINE, Tween.EASE_IN)
	tween.start()
	yield(tween, "tween_completed")
	
	if Global.player_hp <= 0:
		kalah()
		return

	$HBoxContainer/ControlSide/VBoxContainer/BtnStartMatch.disabled = false
	$HBoxContainer/ControlSide/VBoxContainer/BtnAddDMG.disabled = false

# --- OVERLAY & NAVIGASI ---

func menang():
	sfx_player.stream = sound_win
	sfx_player.play()
	log_box.bbcode_text = "KAMU MENANG!"
	get_tree().paused = true
	win_menu.show()

func kalah():
	sfx_player.stream = sound_lose
	sfx_player.play()
	log_box.bbcode_text = "KAMU KALAH!"
	yield(get_tree().create_timer(1.0), "timeout")
	get_tree().paused = true
	lose_menu.show()

func _on_BtnNextStage_pressed():
	MusicManager.play_click()
	get_tree().paused = false
	Global.current_stage += 1
	get_tree().change_scene("res://scene/InGame.tscn")

func _on_BtnRestart_pressed():
	MusicManager.play_click()
	get_tree().paused = false
	Global.player_hp = 100
	get_tree().reload_current_scene()

func _on_BtnAddDMG_pressed():
	MusicManager.play_click()
	get_tree().change_scene("res://scene/Quiz.tscn")

func _on_Pause_pressed():
	MusicManager.play_click()
	get_tree().paused = true
	$UIOverlay/PauseMenu.show()

func _on_BtnContinue_pressed():
	MusicManager.play_click()
	get_tree().paused = false
	$UIOverlay/PauseMenu.hide()

func _on_BtnMainMenu_pressed():
	MusicManager.play_click()
	get_tree().paused = false
	get_tree().change_scene("res://scene/MainMenu.tscn")

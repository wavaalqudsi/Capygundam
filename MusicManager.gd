extends Node

var bgm_player = AudioStreamPlayer.new()
var sfx_click = preload("res://asset/audio/digital-click-357350.mp3")

func _ready():
	add_child(bgm_player)
	# Set pause mode ke Process agar musik tidak mati saat game di-pause
	bgm_player.pause_mode = Node.PAUSE_MODE_PROCESS
	play_menu_theme()

func play_click():
	if sfx_click:
		var p = AudioStreamPlayer.new()
		add_child(p)
		p.stream = sfx_click
		p.play()
		yield(p, "finished")
		p.queue_free()

func play_music():
	if bgm_player.stream and not bgm_player.playing:
		bgm_player.play()

func stop_music():
	bgm_player.stop()

func play_battle_theme():
	var battle_bgm_path = "res://asset/audio/Gundam SEED Destiny Shutsugeki! Impulse - WoWNE.mp3"
	
	# Cek apakah lagu yang sedang diputar sudah sama dengan target
	if bgm_player.stream and bgm_player.stream.resource_path == battle_bgm_path:
		if bgm_player.playing:
			return # Tetap putar lagu yang sama, jangan restart
	
	var battle_bgm = load(battle_bgm_path)
	if battle_bgm:
		bgm_player.stream = battle_bgm
		bgm_player.play()

func play_menu_theme():
	var menu_bgm_path = "res://asset/audio/SEED FREEDOMTMRevolution Meteor Orchestra Ver.mp3"
	
	if bgm_player.stream and bgm_player.stream.resource_path == menu_bgm_path:
		if bgm_player.playing:
			return
			
	var menu_bgm = load(menu_bgm_path)
	if menu_bgm:
		bgm_player.stream = menu_bgm
		bgm_player.play()

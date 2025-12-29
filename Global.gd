extends Node

# Variabel Status Player
var player_hp = 200
var player_dmg = 20
var current_stage = 1

# Variabel Musuh (Akan diupdate setiap ganti stage)
var enemy_hp = 100
var enemy_name = "Robot Musuh"

# Database Soal Kuis (20 Soal)
# Kita gunakan Array of Dictionary agar mudah dikelola
var questions = [
	# --- LOGIKA & MATEMATIKA (1-10) ---
	{"tanya": "Berapa hasil dari 10 + 5 * 2?", "opsi": ["30", "20", "25"], "jawaban": 1},
	{"tanya": "Berapa hasil dari 100 / 4?", "opsi": ["20", "25", "30"], "jawaban": 1},
	{"tanya": "Jika x = 5, berapa nilai dari x * 3 - 2?", "opsi": ["13", "15", "10"], "jawaban": 0},
	{"tanya": "Berapa hasil dari 2 pangkat 5?", "opsi": ["16", "32", "64"], "jawaban": 1},
	{"tanya": "Berapa sisa bagi (modulo) dari 10 % 3?", "opsi": ["1", "0", "3"], "jawaban": 0},
	{"tanya": "Akar kuadrat dari 144 adalah...", "opsi": ["10", "12", "14"], "jawaban": 1},
	{"tanya": "Manakah bilangan prima di bawah ini?", "opsi": ["9", "13", "15"], "jawaban": 1},
	{"tanya": "Hasil dari (15 - 5) * (2 + 2)?", "opsi": ["40", "20", "30"], "jawaban": 0},
	{"tanya": "Berapa nilai biner dari angka 4?", "opsi": ["100", "110", "011"], "jawaban": 0},
	{"tanya": "Berapa hasil dari 1/2 + 1/4?", "opsi": ["1/6", "3/4", "1/2"], "jawaban": 1},

	# --- PENGETAHUAN KOMPUTER (11-20) ---
	{"tanya": "Apa kepanjangan dari CPU?", "opsi": ["Central Processing Unit", "Central Power Unit", "Core Process Unit"], "jawaban": 0},
	{"tanya": "RAM adalah singkatan dari...", "opsi": ["Read Access Memory", "Random Access Memory", "Run Access Memory"], "jawaban": 1},
	{"tanya": "Perangkat keras untuk menyimpan data permanen?", "opsi": ["RAM", "Harddisk/SSD", "Monitor"], "jawaban": 1},
	{"tanya": "Otak dari sebuah komputer disebut...", "opsi": ["Motherboard", "GPU", "Processor"], "jawaban": 2},
	{"tanya": "1 Terabyte sama dengan berapa Gigabyte?", "opsi": ["100 GB", "1000 GB", "1024 GB"], "jawaban": 2},
	{"tanya": "Sistem operasi berlogo pinguin adalah...", "opsi": ["Windows", "Linux", "MacOS"], "jawaban": 1},
	{"tanya": "Alamat unik sebuah komputer di jaringan disebut...", "opsi": ["IP Address", "Home Address", "MAC ID"], "jawaban": 0},
	{"tanya": "Protokol standar untuk browsing web?", "opsi": ["FTP", "HTTP", "SMTP"], "jawaban": 1},
	{"tanya": "Input device di bawah ini adalah...", "opsi": ["Speaker", "Monitor", "Keyboard"], "jawaban": 2},
	{"tanya": "Penyimpanan awan milik Google disebut...", "opsi": ["OneDrive", "Google Drive", "iCloud"], "jawaban": 1},

	# --- PEMROGRAMAN & INFORMATIKA (21-30) ---
	{"tanya": "Bahasa pemrograman utama di Godot?", "opsi": ["GDScript", "C#", "Python"], "jawaban": 0},
	{"tanya": "Simbol untuk memberikan komentar di GDScript?", "opsi": ["//", "#", "/*"], "jawaban": 1},
	{"tanya": "Tipe data untuk angka desimal?", "opsi": ["Integer", "String", "Float"], "jawaban": 2},
	{"tanya": "Tipe data yang hanya bernilai True atau False?", "opsi": ["Boolean", "Array", "Dictionary"], "jawaban": 0},
	{"tanya": "Apa fungsi dari 'print()' dalam pemrograman?", "opsi": ["Mencetak kertas", "Menampilkan teks di konsol", "Menghapus data"], "jawaban": 1},
	{"tanya": "Ekstensi file scene di Godot adalah...", "opsi": [".gd", ".tscn", ".png"], "jawaban": 1},
	{"tanya": "Struktur data yang menggunakan kunci (key) dan nilai (value)?", "opsi": ["Array", "List", "Dictionary"], "jawaban": 2},
	{"tanya": "Looping yang digunakan jika jumlah perulangan sudah tentu?", "opsi": ["for", "while", "if"], "jawaban": 0},
	{"tanya": "Indeks pertama pada sebuah Array dimulai dari...", "opsi": ["1", "0", "-1"], "jawaban": 1},
	{"tanya": "Fungsi yang dipanggil sekali saat objek muncul di Godot?", "opsi": ["_process", "_ready", "_input"], "jawaban": 1}
]

# List untuk menampung soal yang sudah dipakai
var used_questions = []

func reset_game():
	player_hp = 200
	player_dmg = 20
	used_questions.clear()
	
var enemy_list = {
	1: {
		"name": "Bee Bot",
		"hp": 200,
		"dmg": 30,
		"texture": "res://asset/enemy/bee rb.png"
	},
	2: {
		"name": "Mouse Bot",
		"hp": 300,
		"dmg": 40,
		"texture": "res://asset/enemy/mouse_bot-removebg-preview.png"
	},
	3: {
		"name": "Slime Bot",
		"hp": 500,
		"dmg": 50,
		"texture": "res://asset/enemy/slime_bot-removebg-preview.png"
	}
}

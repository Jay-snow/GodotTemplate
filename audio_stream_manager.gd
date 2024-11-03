extends Node

var num_players = 8
var bus = "master"

var available = []  # The available players.
var queue = []  # The queue of sounds to play.

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in num_players:
		var p = AudioStreamPlayer.new()
		add_child(p)
		available.append(p)
		p.finished.connect(_on_stream_finished.bind(p))
		p.bus = bus
		
	#play("res://assets/Music/RippleField3.mp3")
	pass # Replace with function body.


func _on_stream_finished(stream):
	available.append(stream)


func play(sound_path):
	queue.append(sound_path)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if not queue.is_empty() and not available.is_empty():
		available[0].stream = load(queue.pop_front())
		available[0].play()
		available.pop_front()

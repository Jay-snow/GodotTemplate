extends Node2D
@onready var introduction: Control = $CanvasLayer/Introduction
const WORLD_PLATFORMER = preload("res://scenes/world.tscn")
const WORLD = preload("res://levels/demo_world/world.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	introduction.get_node('Start').start_game.connect(_begin_game)
	introduction.get_node('Platformer').start_game_platformer.connect(_begin_platformer)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _begin_game():
	var new_game = WORLD.instantiate()
	add_child(new_game)
	introduction.queue_free()
	pass

	
func _begin_platformer():
	var new_game = WORLD_PLATFORMER.instantiate()
	add_child(new_game)
	introduction.queue_free()
	pass

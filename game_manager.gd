extends Node2D
@onready var introduction: Control = $CanvasLayer/Introduction

const WORLD = preload("res://world.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	introduction.get_node('Start').start_game.connect(_begin_game)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _begin_game():
	var new_game = WORLD.instantiate()
	add_child(new_game)
	introduction.queue_free()
	pass

	

extends Node2D

@onready var texture_rect: TextureRect = $CanvasLayer/Control/Panel/MarginContainer/HBoxContainer/TextureRect

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("left_click"):
		var size = texture_rect.size
		texture_rect.global_position = get_viewport().get_mouse_position() - (size / 2)
	pass

#func _input(event):
	## Mouse in viewport coordinates.
	#if event is InputEventMouseButton:
		#print("Mouse Click/Unclick at: ", event.position)
		#texture_rect.global_position = event.position
	#elif event is InputEventMouseMotion:
		#print("Mouse Motion at: ", event.position)

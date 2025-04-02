extends Node2D

@onready var texture_rect: TextureRect = $CanvasLayer/Control/Panel/MarginContainer/HBoxContainer/TextureRect


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_pressed("left_click"):
		var size = texture_rect.size
		texture_rect.global_position = get_viewport().get_mouse_position() - (size / 2)
	pass

extends Area2D

@onready var icon: Sprite2D = $Icon
var health = 3

func _ready():
	# Connect the input and mouse signals
	input_event.connect(_on_input_event)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	
	# Make sure the shader material is unique to this instance
	var material = icon.material as ShaderMaterial
	if material:
		icon.material = material.duplicate()

func _on_input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			print("Sprite clicked!")
			health -= 1
			take_damage()
			if health <= 0:
				queue_free()

func _on_mouse_entered():
	if icon.material:
		icon.material.set_shader_parameter("hover_active", true)

func _on_mouse_exited():
	if icon.material:
		icon.material.set_shader_parameter("hover_active", false)

func take_damage():
	var tween: Tween = create_tween()
	tween.tween_property(icon, "modulate", Color(1.2, 1.2, 1.2), 0.1)
	tween.tween_property(icon, "modulate", Color(1, 1, 1), 0.1)

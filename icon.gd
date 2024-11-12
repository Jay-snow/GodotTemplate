extends Sprite2D

## Enable mouse input processing for the sprite
#func _ready():
	## Make sure input is handled by this node
	#set_process_input(true)
	## Enable mouse input
	#mouse_filter = Control.MOUSE_FILTER_STOP

# Handle input events
func _input_event(_viewport, event, _shape_idx):
	if event is InputEventMouseButton:
		print(event)
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			print("Sprite clicked!")
			# Add your click handling code here
			
# Optional: Add visual feedback when mouse hovers over sprite
func _mouse_entered():
	modulate = Color(1.2, 1.2, 1.2)  # Slightly brighten the sprite

func _mouse_exited():
	modulate = Color(1, 1, 1)  # Return to normal brightness

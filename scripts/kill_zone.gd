extends Area2D
@onready var timer = $Timer



func _on_body_entered(body):
	timer.start()
	body.get_node("CollisionShape2D").queue_free()
	AudioStreamManager.play("res://assets/Music/ugh.wav")
	Engine.time_scale = 0.5
	

func _on_timer_timeout():
	Engine.time_scale = 1.0
	get_tree().reload_current_scene()
	pass # Replace with function body.

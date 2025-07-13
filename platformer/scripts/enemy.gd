extends Node2D

const SPEED = 60
var direction = 1

@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var animated_sprite = $AnimatedSprite2D	
@onready var ray_cast_up = $RayCastUp

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _process(delta):
	if ray_cast_up.is_colliding():
		var player = ray_cast_up.get_collider()
		player.velocity.y -= 350
		AudioStreamManager.play("res://assets/Music/pingWow.wav")
		queue_free()
	
	if direction == 1:
		animated_sprite.flip_h = true
	elif direction == -1:
		animated_sprite.flip_h = false
	
	if ray_cast_right.is_colliding():
		direction = -1
		
	if ray_cast_left.is_colliding():
		direction = 1
	position.x += direction * SPEED * delta
	


func _on_hitbox_body_entered(body):
	print(body)
	queue_free()
	pass # Replace with function body.

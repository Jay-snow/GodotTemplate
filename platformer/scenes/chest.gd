extends Area2D

@onready var animated_sprite = $AnimatedSprite2D

var has_activated = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body):
	if has_activated == false:
		body.weaponState = body.WEAPON.SWORD
		animated_sprite.play('open')
		has_activated = true

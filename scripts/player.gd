extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -250.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var ray_cast_sword_right = $RayCastSwordRight
@onready var ray_cast_sword_left = $RayCastSwordLeft

enum player {
	IDLE,
	RUNNING,
	ATTACKING,
	TRANSITION_TO_JUMPING,
	JUMPING,
	FALLING,
}

enum WEAPON {
	NONE,
	SWORD
}

var state = player.IDLE
var weaponState = WEAPON.NONE

var DEBUG = false

var has_sword = false
var is_attacking = false

func _ready():
	ray_cast_sword_right.enabled = false
	ray_cast_sword_left.enabled = false
	pass

func debug_helper(debug_message):
	if DEBUG:
		print(debug_message)

func attack_sword(delta, direction):
	
	if weaponState == WEAPON.SWORD && animated_sprite.get_animation() != 'attack_sword_1':
		print('attack sword')
		animated_sprite.play("attack_sword_1")
	if direction > 0:
		ray_cast_sword_right.enabled = true
		ray_cast_sword_left.enabled = false
	elif direction < 0:
		ray_cast_sword_right.enabled = false
		ray_cast_sword_left.enabled = true
		
	if ray_cast_sword_right.is_colliding():
		var enemy = ray_cast_sword_right.get_collider()
		if enemy and animated_sprite.get_animation() == 'attack_sword_1':
			enemy.get_parent().queue_free()
			AudioStreamManager.play("res://assets/Music/pingWow.wav")
	if ray_cast_sword_left.is_colliding():
		var enemy = ray_cast_sword_left.get_collider()
		if enemy and animated_sprite.get_animation() == 'attack_sword_1':
			enemy.get_parent().queue_free()
			AudioStreamManager.play("res://assets/Music/pingWow.wav")
		
		#is_attacking = true
		
	
	#ray_cast_sword_right.enabled = true
	#ray_cast_sword_left.enabled = true


func idle():
	if weaponState == WEAPON.NONE && animated_sprite.get_animation() != 'idle':
		animated_sprite.play('idle')
	if weaponState == WEAPON.SWORD && animated_sprite.get_animation() != 'idle_sword':
		animated_sprite.play('idle_sword')
		

		
func running(delta, direction):
	if weaponState == WEAPON.NONE && animated_sprite.animation != 'run':
		animated_sprite.play('run')
	if weaponState == WEAPON.SWORD && animated_sprite.animation != 'run_sword':
		animated_sprite.play('run_sword')
	#Flip the sprite
	if direction > 0 :
		animated_sprite.flip_h = false;
	elif direction < 0:
		animated_sprite.flip_h = true

	
func trans_to_jumping(delta, direction):
	velocity.y = JUMP_VELOCITY
	animated_sprite.play('jump')
	AudioStreamManager.play("res://assets/sfx/sfx_jump.wav")
	state = player.JUMPING
	

func jumping():
	if velocity.y > 120:
		state = player.FALLING

func falling():
	if velocity.y > 120:
		if weaponState == WEAPON.NONE && !is_attacking:
			animated_sprite.play('fall')
		elif !is_attacking:
			animated_sprite.play('fall_sword')
	elif animated_sprite.get_animation() != 'jump':
		if weaponState == WEAPON.NONE && !is_attacking:
			animated_sprite.play('jump')
		elif !is_attacking:
			animated_sprite.play('jump_sword')

func _physics_process(delta):
	
	# Get input direction ( example: -1, 0, 1)
	var direction = Input.get_axis("move_left", "move_right")
	if state != player.ATTACKING:
		if direction == 0 && is_on_floor():
			state = player.IDLE
		if direction != 0 && is_on_floor():
			state = player.RUNNING
		if is_on_floor() && Input.is_action_just_pressed("jump"):
			state = player.TRANSITION_TO_JUMPING


	if Input.is_action_just_pressed("action") && weaponState == WEAPON.SWORD:
		state = player.ATTACKING	

	match state:
		player.IDLE:
			idle()
		player.RUNNING:
			running(delta, direction)
		player.TRANSITION_TO_JUMPING:
			trans_to_jumping(delta, direction)
		player.JUMPING:
			jumping()
		player.FALLING:
			falling()
		player.ATTACKING:
			attack_sword(delta, direction)
			
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		
	# movement logic
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _on_animated_sprite_2d_animation_finished():
	if animated_sprite.get_animation() == 'attack_sword_1':
		state = player.IDLE

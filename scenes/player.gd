extends CharacterBody2D

@onready var _animation_player = $AnimatedSprite2D
@export var speed = 400.0
var screen_size

func _ready():
	screen_size = get_viewport_rect().size
	hide()

func _process(delta):
	# Player controls
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		_animation_player.play("walking")
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		_animation_player.play("walking")
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		_animation_player.play("walking")
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		_animation_player.play("walking")
		velocity.y -= 1
	
	if velocity.length() > 0: # Logic when velocity is more than zero
		# normalize speed
		velocity = velocity.normalized() * speed
	else: # Logic when velocity is not more than zero
		# play idle animation
		$AnimatedSprite2D.play("idle")
		
	if velocity.x < 0: # Logic to flip sprite horizontally when moving in a direction
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false

		
	# update player position and prevent player from leaving screen
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

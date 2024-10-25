extends Area2D

# Collisions
signal hit

@export var speed = 250
var screen_size

# Starting the game
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size


var direction: String = "down"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	var velocity: Vector2 = Vector2.ZERO
	var position_increase: int = 1

	if Input.is_action_pressed("move_rigth"):
		velocity.x += position_increase
	if Input.is_action_pressed("move_left"):
		velocity.x -= position_increase
	if Input.is_action_pressed("move_up"):
		velocity.y -= position_increase
	if Input.is_action_pressed("move_down"):
		velocity.y += position_increase

	# Because the player has an idle state, the animation
	# must start before the movement.
	$AnimatedSprite2D.play()
	var state: String = "idle"
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		state = "walk"

	# var direction: String
	# var direction: String = "down"

	var player_size = $CollisionShape2D.shape.get_rect().size
	position += velocity * delta
	position = position.clamp(Vector2.ZERO + player_size, screen_size - player_size)

	if velocity.x > 0 and velocity.y < 0:
		# $AnimatedSprite2D.animation = "walk top rigth"
		direction = "up rigth"
	elif velocity.x > 0 and velocity.y > 0:
		# $AnimatedSprite2D.animation = "walk down rigth"
		direction = "down rigth"
	elif velocity.x < 0 and velocity.y < 0:
		# $AnimatedSprite2D.animation = "walk top left"
		direction = "up left"
	elif velocity.x < 0 and velocity.y > 0:
		# $AnimatedSprite2D.animation = "walk down left"
		direction = "down left"
	elif velocity.x > 0:
		# $AnimatedSprite2D.animation = "walk rigth"
		direction = "rigth"
	elif velocity.x < 0:
		# $AnimatedSprite2D.animation = "walk left"
		direction = "left"
	elif velocity.y < 0:
		# $AnimatedSprite2D.animation = "walk up"
		direction = "up"
	elif velocity.y > 0:
		# $AnimatedSprite2D.animation = "walk down"
		direction = "down"

	$AnimatedSprite2D.animation = state + " " + direction


func _on_body_entered(body: Node2D) -> void:
	# hide() # For the moment we will dissapear the player
	hit.emit() # Emiting the signal
	# print("Hit")
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)

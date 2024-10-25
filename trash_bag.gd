extends RigidBody2D

var screen_size

func start(pos):
	position = pos
	show()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# getting the screen size
	# screen_size = get_viewport_rect().size
	# Getting all the types of animation of the trashbag object
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	# plays one of the random animations as it appears
	$AnimatedSprite2D.play(mob_types[randi() % mob_types.size()])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# $AnimatedSprite2D.play()
	# var trash_bag_size = $CollisionShape2D.shape.get_rect().size
	# position = position.clamp(Vector2.ZERO, screen_size)
	# $AnimatedSprite2D.animation = "object"
	pass

func _on_visible_on_screen_notifier_2d_screen_exited():
	# Delete the trashbags when they leave the screen
	queue_free()


func _on_player_body_entered(body: Node2D) -> void:
	pass # Replace with function body.

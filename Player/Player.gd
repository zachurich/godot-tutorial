extends KinematicBody2D



# func _ready():
# 	print('hello world')
const ACCELERATION = 25
const MAX_SPEED = 100
const FRICTION = 45

var velocity = Vector2.ZERO

func _physics_process(delta):
	#* Manual case tree for ref
	#	if Input.is_action_pressed('ui_right'):
	#		velocity.x = 4
	#	elif Input.is_action_pressed('ui_left'):
	#		velocity.x = -4
	#	elif Input.is_action_pressed('ui_up'):
	#		velocity.y = -4
	#	elif Input.is_action_pressed('ui_down'):
	#		velocity.y = 4
	#	else:
	#		velocity = Vector2.ZERO

	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength('ui_right') - Input.get_action_strength('ui_left')
	input_vector.y = Input.get_action_strength('ui_down') - Input.get_action_strength('ui_up')
	input_vector = input_vector.normalized()

  #* When you have something that needs to change over time, multiply by delta :)
	if input_vector != Vector2.ZERO:
		velocity += input_vector * ACCELERATION * delta
		velocity = velocity.limit_length(MAX_SPEED * delta)
	else: 
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	print(velocity)
		
	move_and_collide(velocity)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

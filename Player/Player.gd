extends KinematicBody2D



# func _ready():
# 	print('hello world')
const ACCELERATION = 600
const MAX_SPEED = 80
const FRICTION = 700

var velocity = Vector2.ZERO
var lastDirection = "right";

onready var animationPlayer = $AnimationPlayer

#This is long form for onready var
#var animationPlayer = null
#func _ready():
#	animationPlayer = $AnimationPlayer
	

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
		if input_vector.x > 0:
			lastDirection = "right"
		elif input_vector.x < 0:
			lastDirection = "left"
			
		if input_vector.y > 0:
			lastDirection = "down";
		elif input_vector.y < 0:
			lastDirection = "up";

		animationPlayer.play("run_{direction}".format({"direction": lastDirection}))
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
	else: 
		animationPlayer.play("idle_{direction}".format({"direction": lastDirection}))
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)

	print(velocity)
		
	var new_velocity = move_and_slide(velocity)
	velocity = new_velocity


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

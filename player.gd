extends CharacterBody2D

@export var speed = 1000
@export var jump_velocity = -1000
@export var gravity = 980

@export_range(0, 1) var friction = 0.2
@export_range(0, 1) var acceleration = 0.2

var direction = 0

func _process(delta):
	# plays idle animation if not moving
	$AnimatedSprite2D.play("idle" if direction == 0 else "run")
	
	# flip sprite if going left
	$AnimatedSprite2D.flip_h = direction < 0

# movement inspo taken from
# https://kidscancode.org/godot_recipes/4.x/2d/platform_character/index.html
func _physics_process(delta):
	# apply gravity
	velocity.y += gravity
	
	direction = Input.get_axis("move_left", "move_right")
	
	if direction == 0:
		velocity.x = lerp(velocity.x, 0.0, friction)
	else: 
		velocity.x = lerp(velocity.x, direction * speed, acceleration)
		#velocity.x += direction * speed * delta
	
	move_and_slide()
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_velocity
		print('jump')
	
	

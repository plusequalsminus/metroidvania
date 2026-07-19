extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

enum States {IDLE, WALKING, RUNNING, JUMPING, DASHING}
var state: States = States.IDLE

var lastdir = 1
var dashing = 1
var jumps = 0


func _ready() -> void:
	$sword/sprite.visible = false


func _physics_process(delta: float) -> void:
	#Show Health
	$healthCounter.text = str(Global.health)
	
	#Debug Tools
	print(velocity.x)
	
	#Direction
	var direction := Input.get_axis("left", "right")
	
	#Deceleration when dashing
	if state == States.DASHING:
		velocity.x = lerp(velocity.x, velocity.x * 0, 0.07)
	#Handle dash
	if Input.is_action_just_pressed("dash"):
		state = States.DASHING
		$DashingEffects.emitting = true
		velocity.x = lerp(velocity.x, velocity.x + 8500 * lastdir, 0.1)
		await get_tree().create_timer(0.25).timeout
		state = States.IDLE

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	#Handle attacking
	if Input.is_action_just_pressed("attack"):
		$sword.monitoring = true
		$sword/hitbox.disabled = false
		$sword/sprite.visible = true
		await get_tree().create_timer(0.25).timeout
		$sword.monitoring = false
		$sword/hitbox.disabled = true
		$sword/sprite.visible = false

	# Handle jump.
#	if jumps == 1:
#		$JumpingEffects.emitting = true
	if Input.is_action_just_pressed("up") and is_on_floor() or Input.is_action_just_pressed("up") and jumps < 1:
		jumps += 1
		velocity.y = JUMP_VELOCITY
	if is_on_floor():
		jumps = 0
	#
	if state == States.IDLE or state == States.WALKING:
		if direction:
			velocity.x = direction * SPEED * dashing
			state = States.WALKING
			if direction == 1:
				$sword.position = Vector2(25, 5)
				$DashingEffects.direction.x = -1
				$DashingEffects.direction.y = -1
				lastdir = 1
			else:
				$sword.position = Vector2(-25, 5)
				$DashingEffects.direction.x = 1
				$DashingEffects.direction.y = 1
				lastdir = -1
		else:
		#For lerp, use REALLY low numbers
			velocity.x = lerp(velocity.x, velocity.x * 0, 0.3)
#		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

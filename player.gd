extends CharacterBody2D


#Constants
const SPEED = 250.0
const JUMP_VELOCITY = -400.0

#States
enum States {IDLE, WALKING, RUNNING, JUMPING, DASHING, FALLING}
var state: States = States.IDLE

#Variables
var dashing = 1
var jumps = 0
var fireball := preload("res://fireball.tscn")
var instance := fireball.instantiate()
var direction := Input.get_axis("left", "right")
func _ready() -> void:
	#Make sure sword is invisible
	$sword/sprite.visible = false
	
	
	
func _physics_process(delta: float) -> void:
	
	
	#Fireball
	if Input.is_action_just_pressed("fireball"):
		print(Global.lastdir)
		instance = fireball.instantiate()
		add_child(instance)
		Global.fireballed = true
	
	
	#Manage iframes
	Global.iframes -= 1
	
	if Global.iframes > 0:
		$sprite.modulate = 150001100
	else:
		$sprite.modulate = Color(0.0, 0.0, 1.0, 1.0)
	
	#Max health
	if Global.health > Global.max_health:
		Global.health = Global.max_health
	
	#Debug tools
	$state.text = str(state)
	
	#Death screen
	if Global.health < 1:
		get_tree().change_scene_to_file("res://gameover.tscn")
		
	#Show health
	$healthCounter.text = str(Global.health)
	
	
	#Direction
	var direction := Input.get_axis("left", "right")
	
	#Deceleration when dashing
	if state == States.DASHING:
		velocity.x = lerp(velocity.x, velocity.x * 0, 0.07)
	
	#Handle dash
	if Input.is_action_just_pressed("dash"):
		state = States.DASHING
		$DashingEffects.emitting = true
		velocity.x = lerp(velocity.x, velocity.x + 8500 * Global.lastdir, 0.1)
		await get_tree().create_timer(0.25).timeout
		state = States.IDLE
	
	# Handle gravity
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	#Handle attacking
	if Input.is_action_just_pressed("attack"):
		$sword.monitoring = true
		$sword/hitbox.disabled = false
		$sword/sprite.visible = true
		await get_tree().create_timer(0.1).timeout # origninally 0.25 wait time
		$sword.monitoring = false
		$sword/hitbox.disabled = true
		$sword/sprite.visible = false
	
	# Handle jump VFX.
	if jumps == 1:
		$JumpingEffects.emitting = true
	
	#Handle jump
	if Input.is_action_just_pressed("up") and is_on_floor() or Input.is_action_just_pressed("up") and jumps < 1:
		jumps += 1
		velocity.y = JUMP_VELOCITY
		state = States.JUMPING
	
	if is_on_floor():
		jumps = 0
	
	#Handle walking, states, dash VFX, sword position... too much
	if state == States.IDLE or state == States.WALKING or state == States.JUMPING or state == States.FALLING:
		if direction:
			velocity.x = direction * SPEED * dashing
			state = States.WALKING
			
			if direction == 1:
				$sword.position = Vector2(25, 5)
				$DashingEffects.direction.x = -1
				$DashingEffects.direction.y = -1
				Global.lastdir = 1
				
			elif direction == -1:
				$sword.position = Vector2(-25, 5)
				$DashingEffects.direction.x = 1
				$DashingEffects.direction.y = 1
				Global.lastdir = -1
		else:
		#For lerp, use REALLY low numbers
			velocity.x = lerp(velocity.x, velocity.x * 0, 0.3)
			
			if velocity.y == 0:
				state = States.IDLE
				
			elif velocity.y < 0:
				state = States.JUMPING
				
			elif velocity.y > 0:
				state = States.FALLING
	
	
	move_and_slide()

extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -400.0
var direction = 1
func _ready() -> void:
	direction = 1

func _physics_process(delta: float) -> void:
	velocity.x = direction * SPEED
	
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.


	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.

	if $raycastright.is_colliding() or not $raycastrightground.is_colliding():
		direction = -1
	if $raycastleft.is_colliding() or not $raycastleftground.is_colliding():
		direction = 1
#	velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()



#	if body.is_in_group("weapon"):
#		print("Hit!")
#		$sprite.visible = false
#		$hitbox.disabled = true
#		set_deferred("disabled",true)


func _on_hitarea_area_entered(area: Area2D) -> void:
	if area.is_in_group("weapon"):
		print("Hit!")
		$sprite.visible = false
		$VFX.emitting = true
		$hitbox.set_deferred("disabled", true)

extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_fall_area_body_entered(body: Node2D) -> void:
	$player.global_position = $respawnPoint.global_position
	Global.health -= 1


func _on_pressure_plate_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
#		%door/hitbox.set_deferred("disabled", true)
		%door/sprite.visible = false
		await get_tree().create_timer(0.5).timeout
#		%door/hitbox.set_deferred("disabled", false)
		%door/sprite.visible = true

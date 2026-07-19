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

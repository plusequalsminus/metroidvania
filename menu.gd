extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
#	$camera.position = get_local_mouse_position()


func _on_play_butt_pressed() -> void:
	get_tree().change_scene_to_file("res://starting_room.tscn")


func _on_music_finished() -> void:
	$mus_timer.start()


func _on_mus_timer_timeout() -> void:
	$music.play()

extends Area2D

var interactable = false
var dialogue = ""
var interact_count = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$prompt.visible = false
	$text.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$text.text = str(dialogue)
	if Input.is_action_just_pressed("interact") and interactable == true:
		if interact_count == 0:
			dialogue = "Hello!"
			interact_count += 1
		
		elif interact_count == 1:
			dialogue = "You look hungry!"
			interact_count += 1
		
		elif interact_count == 2:
			dialogue = "Too bad."
			interact_count += 1
			await get_tree().create_timer(5).timeout
			dialogue = ""
		
		elif interact_count > 2:
			dialogue = "What?"
			await get_tree().create_timer(5).timeout
			dialogue = ""
		
		elif interact_count < 0:
			dialogue = "What have you done?"
		$text.visible = true
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		interactable = true
		$prompt.visible = true


func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		$prompt.visible = false
		interactable = false

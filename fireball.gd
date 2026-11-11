extends Area2D
@onready var thisfiredir = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position = get_parent().global_position
	thisfiredir = Global.lastdir
	print(str(Global.lastdir) + str(thisfiredir))
	await get_tree().create_timer(1).timeout
	queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position.x += 10 * thisfiredir


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemy"):
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		queue_free()

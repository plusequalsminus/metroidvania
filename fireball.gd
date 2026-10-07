extends Area2D
@onready var thisfiredir = 1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_position = get_parent().global_position
	thisfiredir = Global.lastdir
	print(str(Global.lastdir) + str(thisfiredir))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position.x += 10 * thisfiredir

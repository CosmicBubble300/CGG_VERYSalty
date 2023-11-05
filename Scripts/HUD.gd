extends CanvasLayer


# Declare member variables here. Examples:
# Loads global variables 
onready var global_vars = get_node("/root/Global")

# Called when the node enters the scene tree for the first time.
func _ready():
	$O2Counter/O2CounterText.text = String(len(global_vars.tank_list))


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Character_tanks_update():
	$O2Counter/O2CounterText.text = String(len(global_vars.tank_list))

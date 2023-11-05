extends KinematicBody2D



### SIGNALS ###


## Animation ##
#func _ready():
#	var frames = $RigidBody2D/AnimatedSprite2D.sprite_frames.get_animation_named()
	

### CONSTANTS ###
# Defines constants for movement speed 
export var regspeed = 120
export var run = 145



### Variables ###

# Define Movements Variables 
var mcpos # main character position
var targetpos # target position of enemy
onready var mc = get_parent().get_node("Character") #get main char

### MOVEMENT ###
func _physics_process(delta):
	mcpos = mc.position # get mc position
	targetpos = (mcpos - position).normalized() #normalize distance
	
	#if player close enough
	if position.distance_to(mcpos) > 3:
		move_and_slide(targetpos * run)


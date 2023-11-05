extends KinematicBody2D

### CONSTANTS ###
# Defines constants for movement speed 
const regspeed = 200
const run = 700

### Variables ###
# Define Movements Variables 
var mcpos # main character position
var targetpos # enemy moves to this target when a player is detected
var randompos # enemy moves here randomly
onready var mc = get_parent().get_node("Character") #get main char
var x = rand_range(-1000, 15000) # x coordinate for random move
var y = rand_range(-1000, 15000) # y coordinate for random move


### MOVEMENT ###
func _physics_process(delta):
	mcpos = mc.position # get mc position
	targetpos = (mcpos - position).normalized() #normalize vector
	randompos = (Vector2(x, y) - position).normalized()
	
	#if player is close enough
	if position.distance_to(mcpos) < 2500:
		move_and_slide(targetpos * run) # gun for them
	else: # otherwise patrol randomly
		move_and_slide(randompos * regspeed) 
	
func _on_Timer_timeout():
	x = rand_range(-1000, 15000)
	y = rand_range(-1000, 15000)
	
	pass # Replace with function body.

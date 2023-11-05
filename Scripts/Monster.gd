extends KinematicBody2D


## Animation ##
#func _ready():
#	var frames = $RigidBody2D/AnimatedSprite2D.sprite_frames.get_animation_named()
	

### CONSTANTS ###
# Defines constants for movement speed 
export var regspeed = 120
export var run = 145


### Variables ###
# constants 
const RUN = [1600,1200]
const WALK = [1199,800]
const CRAWL = [799,100]

# Variables 
var stamina = 500       # how much energy the monster has to maul you   
var move_speed = 0      # movement speed 
var movegen = RandomNumberGenerator.new()  # Generates rand speed at which monster moves 


# Define Movements Variables 
var mcpos # main character position
var targetpos # target position of enemy
onready var mc = get_parent().get_node("Character") #get main char

### MOVEMENT ###
func _physics_process(delta):
	# Defines how fast the monster is chasing the player
	# if stamina is over 400 - sprint 
	movegen.randomize()
	if stamina > 400:
		move_speed = movegen.randi_range(RUN[0],RUN[1])
		print(move_speed)
		# sprinting decays stamina by 3 (our boy is not fit)

	elif stamina <= 100 and stamina >= 400:
		# if stamina is between 400 and 100 movement = walk
		move_speed = movegen.randi_range(WALK[0],WALK[1])
		stamina -= 1
	elif stamina > 100:
		# if its less than that we move at a crawl
		move_speed = movegen.randi_range(CRAWL[0], CRAWL[1])
		stamina += 3
	
	
	mcpos = mc.position # get mc position
	targetpos = (mcpos - position).normalized() #normalize distance
	
	#if player close enough
	if position.distance_to(mcpos) > 3:
		move_and_slide(targetpos * move_speed)


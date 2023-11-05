extends KinematicBody2D

### SIGNALS ###
signal game_over    # Player has been killed

### CONSTANTS ###
# Defines constants for movement speed 
const CROUCH = 500
const WALK = 1250
const RUN = 1500

# Defines constants for health and oxygen consumption
const O2MAX = 100
const O2CONSBASE = 1     # rate of O2 consumption while walking
const O2CONSRUN = 3      # rate of O2 consumption while running 
const TANKMAX = 3        # The maximum numner of O2 tanks you can carry 

### Variables ###
# Loads global variables 
onready var global_vars = get_node("/root/Global")

# Variables for health and oxygen consumption 
var O2 = 100                # Max O2
var O2_change = O2CONSBASE  # regular rate of O2 depletion
var overtime = 10           # Amount of time you can live without air 

# Tank Variables 
var tank_full = 100        # How much oxygen is in a full tank

# Define Movements Variables 
# How fast a character is going 
var velocity : Vector2 = Vector2()
# What direction a character is looking in 
var direction : Vector2 = Vector2()


### MOVEMENT ###
func read_input():
	# refidines velocity as an empty vector 
	velocity = Vector2()
	
	if Input.is_action_pressed("UP"):
		velocity.y -= 1
		direction = Vector2(0,-1)
		
	if Input.is_action_pressed("DOWN"):
		velocity.y += 1
		direction = Vector2(0, 1)
		
	if Input.is_action_pressed("L"):
		velocity.x -= 1
		direction = Vector2(-1, 0)
		
	if Input.is_action_pressed("R"):
		velocity.x += 1
		direction = Vector2(1, 0)
		
	# prevents you moving twice as fast on the diagonals 
	velocity = velocity.normalized()
	
	# Applies walking, running and crouching speed to the character
	if Input.is_action_pressed("SPRINT"):
		# checks for collision and makes movement smooth
		velocity = move_and_slide(velocity * RUN)
		# Increases oxygen consumption while runing 
		O2_change = O2CONSRUN
	elif Input.is_action_pressed("CROUCH"):
		velocity = move_and_slide(velocity * CROUCH)
		# Sets oxygen consumption to normal
		O2_change = O2CONSBASE
	else:
		velocity = move_and_slide(velocity * WALK)
		# Sets oxygen consumption to normal
		O2_change = O2CONSBASE
		
# calls the movement function that defines the player movement
func _physics_process(delta):
	# reads imput around 60 times per second 
	read_input()
	
	
### OXYGEN ###

# Recieves signal from timer to decrease Oxygen 
func _on_OxygenTimer_timeout():
	#Decreases the amount of oxygen in the bar as a function of time 
	$OxygenBar.value -= O2_change
	# Replenishes O2 with spare tank when oxygen is empty
	if $OxygenBar.value <= 0 and len(global_vars.tank_list)  != 0:
		$OxygenBar.value = global_vars.tank_list[0]
		# Removes one spare tank
		global_vars.tank_list.remove(0)
	elif $OxygenBar.value <= 0 and len(global_vars.tank_list)  == 0:
		# This code gives the player a window while their character suffocates 
		overtime -= O2_change
		# Kills the character when overtime runs out. 
		if overtime == 0:
			get_tree().change_scene("res://Scenes/GameOverScene.tscn")



### DAMAGE ###
# Creates new random number generator 
var lifechance = RandomNumberGenerator.new()

# Detects collisions with the enemy and kills them 
func _on_HitBox_body_entered(body):
	# generates a random int number 
	lifechance.randomize()                      # removes pseudorandom nature of followng function
	var randNum = lifechance.randi_range(0,10)
	
	# decides what happens on hit 
	if randNum <= 3:
		# if the value is less than the character dies 
		get_tree().change_scene("res://Scenes/GameOverScene.tscn")
		print("dead")
	elif randNum >= 4 and randNum <= 9:
		# if the value is between 4 and 8 you loose an oxygen tank
		print("tank")
		if len(global_vars.tank_list) != 0:
			# removes tank
			global_vars.tank_list.remove(0) 
			# lets you know you can carry more tanks
		else:
			# if you have no oxygen you die 
			get_tree().change_scene("res://Scenes/GameOverScene.tscn")
	else:
		# if your lucky, you live.
		print("live")
		pass
		

extends Node2D

### SIGNALS ###
signal O2_updated

### CONSTANTS ###
const TANKMAX = 3     # max number of O2 tanks you can carry

### VARIABLES ###
# Loads global variables 
onready var global_vars = get_node("/root/Global")


## Sets up random generator for the amount of air in a can ##
var airamount = RandomNumberGenerator.new()


### CODE ###

# detects colision with tank and picks up tank if allowed 
func _on_InArea_body_entered(body):	 
	if len(global_vars.tank_list) != TANKMAX:
		
		# randomizes the amount of air in a canister
		airamount.randomize()
		var randNum = airamount.randi_range(20,100)
		print(randNum)
		# adds air amount to tank list
		global_vars.tank_list.append(randNum)
		
		# adds tank to tankcount
		print(len(global_vars.tank_list))
		# Deletes O2 tank from scene 
		queue_free()
	
	

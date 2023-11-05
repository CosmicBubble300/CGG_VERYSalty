extends KinematicBody2D

var colShift = 0

func _ready():
	while colShift != 1:
		$Aura.color(colShift)
		colShift += 0.01
	pass
	

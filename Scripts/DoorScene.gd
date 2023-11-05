extends Node2D

# Hides door when player approaches 
func _on_Area2D_body_entered(body):
	hide()

# Puts door back when player leaves 
func _on_Area2D_body_exited(body):
	show()

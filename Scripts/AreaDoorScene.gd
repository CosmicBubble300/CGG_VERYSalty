extends Node2D




# Detects 
func _on_Area2D_body_entered(body):
	$Sprite.play("Door Open")
	if $Sprite.playing == false:
		$Area2D/Block.disabled = true
	else:
		$Area2D/Block.disabled = false


func _on_Area2D_body_exited(body):
	$Sprite.play("Door Close")

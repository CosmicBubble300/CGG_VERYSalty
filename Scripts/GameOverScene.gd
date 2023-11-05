extends CanvasLayer



# When re-start button pressed 
func _on_restart_pressed():
	get_tree().change_scene("res://Scenes/MainScene.tscn")

# When quit button pressed 
func _on_quit_toggled(button_pressed):
	get_tree().quit()

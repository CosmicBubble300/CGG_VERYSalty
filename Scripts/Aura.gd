extends Light2D


### COLOR CONST ###
const COL1 = Color("ff0000")
const COL2 = Color("ff00f5")
const TIME_SCALE = 1

var time = 0

func _process(delta:float) -> void:
	self.time += delta * TIME_SCALE
	self.color = COL1.linear_interpolate(COL2, abs(sin(time)))

extends Light2D

### COLOR CONST ###
const COL1 = Color("ff0000")
const COL2 = Color("ff00f5")
var time_rest = 1


var time = 0

func _process(delta:float) -> void:
	self.time += delta * time_rest
	self.color = COL1.linear_interpolate(COL2, abs(sin(time)))

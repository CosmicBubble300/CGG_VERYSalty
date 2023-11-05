extends Light2D


const COL1 = Color("#ad2121")
const COL2 = Color("#400b0b")
var time_rest = 2.5


var time = 0

func _process(delta:float) -> void:
	self.time += delta * time_rest
	self.color = COL1.linear_interpolate(COL2, abs(sin(time)))
 

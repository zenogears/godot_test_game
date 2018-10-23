extends Spatial

# Member variables
export var motion = Vector3()
export var cycle = 1.0
export var rangex = 0
export var rangey = 0
export var rangez = 0
export var sinusoida = 0
var accum = 0.0


func _physics_process(delta):
	accum += delta * (1.0 / cycle) * PI * .5
	
	accum = fmod(accum, PI * 2.0)
	var d = sin(accum + sinusoida)
	var xf = Transform()
	xf[3] = Vector3((xf[3].x + rangex) * d, (xf[3].y + rangey) * d, (xf[3].z + rangez) * d)
	$platform.transform = xf
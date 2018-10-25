extends Area

var cube_rotation = rand_range(120,180)


func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	rotate_x(deg2rad(cube_rotation * delta))
	rotate_y(deg2rad(cube_rotation * delta))
	rotate_z(deg2rad(cube_rotation * delta))

func _on_Box_body_entered(body):
	if body is KinematicBody:
		queue_free()
		global.level_scores += 1
		$'../../GUI/Scores/VBoxContainer/Level_Scores'.text = global.scoresLevelText + str(global.level_scores)
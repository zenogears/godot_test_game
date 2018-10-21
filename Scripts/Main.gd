extends Spatial

var win = false

func _ready():
	$WinPanel.hide()
	$LoosePanel.hide()
	global.level_scores = 0
	$Global_Scores.text = 'All Scores: ' + str(global.global_scores)
	

func _process(delta):
	if Input.is_action_just_pressed("ui_accept") and not win:
		get_tree().reload_current_scene()
	elif Input.is_action_just_pressed("ui_accept") and win:
		global.global_scores += global.level_scores
		$Global_Scores.text = 'All Scores: ' + str(global.global_scores)
		global.go_next_stage()

func _on_Area2_body_entered(body):
	if body is RigidBody:
		$WinPanel.show()
		$Player.speed = 0
		win = true
		body.queue_free()

func _on_Loose_body_entered(body):
	if body is RigidBody:
		$LoosePanel.show()
		$Player.speed = 0
	elif body is KinematicBody:
		$LoosePanel.show()
		$Player.speed = 0

func _on_Panel_mouse_entered():
	get_tree().reload_current_scene()

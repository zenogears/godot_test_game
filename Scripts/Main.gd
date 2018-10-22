extends Spatial

var win = false
onready var SMRT = get_node("CanvasLayer/dialog")

func _ready():
	$WinPanel.hide()
	$LoosePanel.hide()
	global.level_scores = 0
	$Global_Scores.text = 'All Scores: ' + str(global.global_scores)
	#SMRT.connect("dialog_control", self, "do_things")
	show_smrt()

func _on_dialog_dialog_control( info ):
	print(info.answer)

func show_smrt():
	if global.dialogs == 0 and global.current_stage == 1:
		global.dialogs = 1
		get_tree().paused = true
		SMRT.show_text("INTRO","OLD MAN", 0)

	elif global.dialogs == 1 and global.current_stage == 2:
		global.dialogs = 2
		get_tree().paused = true
		SMRT.show_text("INTRO","Freddie", 0)

	elif global.dialogs == 2 and global.current_stage == 3:
		global.dialogs = 3
		get_tree().paused = true
		SMRT.show_text("INTRO","New", 0)
    

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel") and not win:
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

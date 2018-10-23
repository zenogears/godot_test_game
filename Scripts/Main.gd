extends Spatial

var win = false
onready var SMRT = get_node("CanvasLayer/dialog")
var current_stage
onready var WinPanel = $'Panels/WinPanel'
onready var LoosePanel = $'Panels/LoosePanel'
onready var Level_Scores = $'Scores/VBoxContainer/Level_Scores'
onready var Global_Scores = $'Scores/VBoxContainer/Global_Scores'


func _ready():
	current_stage = int(get_tree().get_current_scene().get_name().replace('Level',''))
	save.save_game()
	WinPanel.hide()
	LoosePanel.hide()
	global.level_scores = 0
	Global_Scores.text = global.scoresAllText + str(global.global_scores)
	#SMRT.connect("dialog_control", self, "do_things")
	show_smrt(current_stage)
	

func _on_dialog_dialog_control( info ):
	print(info.answer)

func show_smrt(current_stage):
	if global.dialogs == current_stage - 1:
		global.dialogs = current_stage
		#get_tree().paused = true
		SMRT.show_text(global.dialog_stages[current_stage][0], global.dialog_stages[current_stage][1], global.dialog_stages[current_stage][2])

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel") and not win:
		get_tree().reload_current_scene()
	elif Input.is_action_just_pressed("ui_accept") and win:
		global.global_scores += global.level_scores
		Global_Scores.text = global.scoresAllText + str(global.global_scores)
		global.go_next_stage()

func _on_Area2_body_entered(body):
	if body is RigidBody:
		WinPanel.show()
		$Player.speed = 0
		win = true
		body.queue_free()

func _on_Loose_body_entered(body):
	if body is RigidBody and not body.is_in_group("platform"):
		LoosePanel.show()
		$Player.speed = 0
	elif body is KinematicBody and not body.is_in_group("platform"):
		LoosePanel.show()
		$Player.speed = 0

func _on_Panel_mouse_entered():
	get_tree().reload_current_scene()

func save():
	var save_dict = {
			progress_data = {
				current_stage = global.current_stage,
				global_scores = global.global_scores,
				dialogs = global.dialogs
			}
	}
	return save_dict
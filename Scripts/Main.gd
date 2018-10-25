extends Spatial

var win = false
onready var SMRT = $"CanvasLayer/dialog"
var curstage
onready var WinPanel = $'GUI/Panels/WinPanel'
onready var LoosePanel = $'GUI/Panels/LoosePanel'
onready var Level_Scores = $'GUI/Scores/VBoxContainer/Level_Scores'
onready var Global_Scores = $'GUI/Scores/VBoxContainer/Global_Scores'

func _ready():
	curstage = int(get_tree().get_current_scene().get_name().replace('Level',''))
	save.save_game()
	_gui_hide()
	global.level_scores = 0
	Global_Scores.text = global.scoresAllText + str(global.global_scores)
	SMRT.connect("dialog_control", self, "do_things")
	ProjectSettings.playerName = 'Test'
	ProjectSettings.money = 1
	show_smrt(curstage)

func _gui_hide():
	WinPanel.hide()
	LoosePanel.hide()
	Level_Scores.hide()
	Global_Scores.hide()

func _on_dialog_dialog_control( info ):
	print(info.answer)

func show_smrt(stage):
	if global.dialogs == stage - 1:
		global.dialogs = stage
		get_tree().paused = true
		SMRT.show_text(global.dialog_stages[stage][0], global.dialog_stages[stage][1], global.dialog_stages[stage][2])

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel") and not win:
		get_tree().reload_current_scene()
	elif Input.is_action_just_pressed("ui_accept") and win:
		global.global_scores += global.level_scores
		Global_Scores.text = global.scoresAllText + str(global.global_scores)
		#global.go_next_stage()
		global.current_stage += 1
		global.go_scene('Cut')

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
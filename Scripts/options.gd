extends Control

onready var soundScrollBare = $VBoxContainer/opt/VBoxContainer/Container/VBoxContainer/Hbox/HScrollBar
onready var soundmute = $VBoxContainer/opt/VBoxContainer/Container/VBoxContainer/Hbox/CheckBox
onready var SoundNode = global.find_node_by_name(get_tree().get_root(), "Audio")

var SoundMin = 0

func _ready():
	if SoundNode:
		soundScrollBare.value = SoundNode.volume_db
		SoundMin = soundScrollBare.min_value

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		_on_Button_pressed()

func _on_HScrollBar_value_changed(value):
	SoundNode.volume_db = soundScrollBare.value
	if !soundmute.pressed:
		global.lastSoundValue = SoundNode.volume_db
	if value == SoundMin:
		soundmute.pressed = 1
	else:
		soundmute.pressed = 0

func _on_CheckBox_pressed():
	if soundmute.pressed:
		global.lastSoundValue = SoundNode.volume_db
		SoundNode.volume_db = SoundMin
		soundScrollBare.value = SoundMin
		soundmute.pressed = 1
		
	elif !soundmute.pressed:
		soundmute.pressed = 0
		SoundNode.volume_db = global.lastSoundValue
		soundScrollBare.value = global.lastSoundValue

func _on_Button_pressed():
	get_tree().paused = false
	var rootinya = get_tree().get_current_scene().get_name()
	if 'Level' in str(rootinya):
		var Level_Scores = '/root/'+str(rootinya)+'/GUI/Scores/VBoxContainer/Level_Scores'
		var Global_Scores = '/root/'+str(rootinya)+'/GUI/Scores/VBoxContainer/Global_Scores'
		get_node(Level_Scores).show()
		get_node(Global_Scores).show()
	queue_free()

extends Node

var current_stage = 1
var level_scores = 0
var global_scores = 0
var dialogs = 0
var dialog_stages = {1:["INTRO","OLD MAN", 0], 2:["INTRO","Freddie", 0],3:["INTRO","dynamic", 0]}
var scoresAllText = 'Всего кубов: '
var scoresLevelText = 'Кубов на уровне: '

func go_next_stage():
	current_stage += 1
	if current_stage < len(dialog_stages) + 1:
		get_tree().change_scene("res://Scenes/Levels/Level" + str(current_stage) + ".tscn")
	else:
		get_tree().change_scene("res://Scenes/TitleScreen.tscn")
extends Node

var current_stage = 1
var level_scores = 0
var global_scores = 0
var dialogs = 0

func go_next_stage():
	current_stage += 1
	if current_stage < 3:
		get_tree().change_scene("res://Scenes/Levels/Level" + str(current_stage) + ".tscn")
	else:
		get_tree().change_scene("res://Scenes/TitleScreen.tscn")
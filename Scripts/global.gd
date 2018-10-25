extends Node

var current_stage = 1
var level_scores = 0
var global_scores = 0
var dialogs = 0
var dialog_stages = {1:["INTRO","OLD MAN", 0], 2:["INTRO","Freddie", 0],3:["INTRO","dynamic", 0]}
var scoresAllText = 'Всего кубов: '
var scoresLevelText = 'Кубов на уровне: '
var lastSoundValue = 0
var optionsOn = 0

func go_next_stage():
	
	if current_stage < len(dialog_stages) + 1:
		go_scene("Levels/Level" + str(current_stage))
	else:
		go_scene('TitleScreen')
		
func go_scene(_scene):
	get_tree().change_scene("res://Scenes/"+_scene+".tscn")
	
func find_node_by_name(root, name):
	if(name in root.get_name()): return root
	for child in root.get_children():
		if(name in child.get_name()):
			return child
		var found = find_node_by_name(child, name)
		if(found): return found
	return null
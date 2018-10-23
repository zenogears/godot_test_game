extends Node

const SAVE_PATH = 'res://save.json'
var _settings = {}

func _ready():
	pass

func save_game():
	var save_dict = {}
	var nodes_to_save = get_tree().get_nodes_in_group('persistent')
	for node in nodes_to_save:
		save_dict[node.get_path()] = node.save()
	var save_file = File.new()
	save_file.open(SAVE_PATH, File.WRITE)
	save_file.store_line(to_json(save_dict))
	save_file.close()

func load_game():
	var save_file = File.new()
	if not save_file.file_exists(SAVE_PATH):
		return
	var data = {}
	save_file.open(SAVE_PATH, File.READ)
	data = parse_json(save_file.get_as_text())
	print(data)
	
	for node_path in data.keys():
		var node = get_node(node_path)
		
		for attribute in data[node_path]:
			if attribute == 'progress_data':
				global.current_stage = data[node_path][attribute]["current_stage"]
				global.dialogs = data[node_path][attribute]["dialogs"]
				global.global_scores = data[node_path][attribute]["global_scores"]
			#else:
			#	node.set(attribute,data[node_path][attribute])
	print('try load the game')
	print("res://Scenes/Levels/Level" + str(global.current_stage) + ".tscn")
	get_tree().change_scene("res://Scenes/Levels/Level" + str(global.current_stage) + ".tscn")
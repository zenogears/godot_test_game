extends Button

onready var OPTIONS = preload("res://Scenes/options.tscn")

func _on_Options_pressed():
	var opt = OPTIONS.instance()
	#get_node('/root').add_child(opt)
	#get_node('/root/Control/CanvasLayer')
	get_node('/root/TitleScreen/GUI').add_child(opt)

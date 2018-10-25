extends Node

var levels = {1:{'header':'История первая','info':'В которой знакомимся с Яичком',},
2:{'header':'История вторая','info':'В которой мы преодолеваем первые трудности'},
3:{'header':'Глава третья','info':'В которой мы учимся прыгать'},}

func _ready():
	_generation_labels(levels[global.current_stage]['header'],levels[global.current_stage]['info'])
	print(global.current_stage)

func _input(event):
	if Input.is_action_just_pressed("ui_accept"):
		#if not (event is InputEventMouseButton): return
		#global.go_next_stage()
		get_tree().change_scene("res://Scenes/Levels/Level"+str(global.current_stage)+".tscn")

func _generation_labels(Part, Info):
	$Control/Label.text = Part
	$Control/Label2.text = Info
	$Control/Sprite.texture = load("res://Sprites/Level"+str(global.current_stage)+".jpg")
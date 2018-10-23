extends Node

const SAVE_PATH = "res://config.cfg"

var _config_file = ConfigFile.new()
var _settings = {
	"application":
		{
			#"name": ProjectSettings.get("Config/Name")
			"name":'Test'
		}
}

func _ready():
	save_settings()
	load_settings()

func save_settings():
	for section in _settings.keys():
		for key in _settings[section]:
			_config_file.set_value(section, key, _settings[section][key])
	_config_file.save(SAVE_PATH)

func load_settings():
	var error = _config_file.load(SAVE_PATH)
	if error != 0:
		print("Failed to load config file. Error code: %s" % error)
		return []
	for section in _settings.keys():
		for key in _settings[section]:
			_settings[section][key] = _config_file.get_value(section, key, null)

func get_settings(category, key):
	return _settings[category][key]

func set_settings(category, key, value):
	_settings[category][key] = value
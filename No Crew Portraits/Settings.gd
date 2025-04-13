extends "res://Settings.gd"

var NoCrewPortraits = {
	"mainToggles":{
		"hideEnceladus":true,
		"hideOMS":true,
	}, 
}


var NoCrewPortraitsPath = "user://cfg/NoCrewPortraits.cfg"
var NoCrewPortraitsFile = ConfigFile.new()

func _ready():
	var dir = Directory.new()
	dir.make_dir("user://cfg")
	loadNoCrewPortraitsFromFile()
	saveNoCrewPortraitsToFile()


func saveNoCrewPortraitsToFile():
	for section in NoCrewPortraits:
		for key in NoCrewPortraits[section]:
			NoCrewPortraitsFile.set_value(section, key, NoCrewPortraits[section][key])
	NoCrewPortraitsFile.save(NoCrewPortraitsPath)


func loadNoCrewPortraitsFromFile():
	var error = NoCrewPortraitsFile.load(NoCrewPortraitsPath)
	if error != OK:
		Debug.l("Example Mod Menu Config: Error loading settings %s" % error)
		return 
	for section in NoCrewPortraits:
		for key in NoCrewPortraits[section]:
			NoCrewPortraits[section][key] = NoCrewPortraitsFile.get_value(section, key, NoCrewPortraits[section][key])
	loadNoCrewPortraitsKeymapFromConfig()

# No examples directly given for keybinds, check Za'krin's ZKY mod for references for this
func loadNoCrewPortraitsKeymapFromConfig():
	for action_name in NoCrewPortraits.input:
		InputMap.add_action(action_name)
		for key in NoCrewPortraits.input[action_name]:
			var event = InputEventKey.new()
			event.scancode = OS.find_scancode_from_string(key)
			InputMap.action_add_event(action_name, event)
	emit_signal("controlSchemeChaged")

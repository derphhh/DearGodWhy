extends Button

# Preload the GameModeSelection scene
var collected_scene = preload("res://Scenes/deck/collected/collected.tscn")
func _ready():
	connect("pressed", self, "_on_PlayButton_pressed")

func _on_PlayButton_pressed():
	get_tree().change_scene_to(collected_scene)

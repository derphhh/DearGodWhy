extends Control

# Preload the GameModeSelection scene
var display = preload("res://Scenes/packs/common/Display.tscn")
func _ready():
	connect("pressed", self, "_on_PlayButton_pressed")

func _on_PlayButton_pressed():
	get_tree().change_scene_to(display)

extends Control

# Preload the GameModeSelection scene
var button_test = preload("res://ButtonTest.tscn")
func _ready():
	connect("pressed", self, "_on_PlayButton_pressed")

func _on_PlayButton_pressed():
	get_tree().change_scene_to(button_test)

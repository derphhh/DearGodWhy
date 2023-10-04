extends Node

func _ready():
	# Connect the "pressed" signal of the PlayButton to a function
	$PlayButton.connect("pressed", self, "_on_play_button_pressed")

func _on_play_button_pressed():
	# Load the GameModeSelection scene
	var game_mode_scene = preload("res://Scenes/main/GameModeSelection.tscn")
	var game_mode_instance = game_mode_scene.instance()
	
	# Replace the current scene with GameModeSelection
	get_tree().change_scene(game_mode_instance)

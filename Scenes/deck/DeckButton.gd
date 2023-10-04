extends Button

# Preload the GameModeSelection scene
var game_mode_selection = preload("res://Scenes/deck/Deck.tscn")
func _ready():
	connect("pressed", self, "_on_PlayButton_pressed")

func _on_PlayButton_pressed():
	get_tree().change_scene_to(game_mode_selection)

extends Button

# Preload the GameModeSelection scene
var builder_scene = preload("res://Scenes/deck/DeckBuilder/DeckBuilder.tscn")
func _ready():
	connect("pressed", self, "_on_PlayButton_pressed")

func _on_PlayButton_pressed():
	get_tree().change_scene_to(builder_scene)

extends Button

# Preload the GameModeSelection scene
var local_arena = preload("res://Scenes/play_area/Local/Local.tscn")
func _ready():
	connect("pressed", self, "_on_PlayButton_pressed")

func _on_PlayButton_pressed():
	get_tree().change_scene_to(local_arena)

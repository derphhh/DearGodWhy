extends Button

# Preload the GameModeSelection scene
var online_arena = preload("res://Scenes/play_area/Online/Online.tscn")
func _ready():
	connect("pressed", self, "_on_PlayButton_pressed")

func _on_PlayButton_pressed():
	get_tree().change_scene_to(online_arena)

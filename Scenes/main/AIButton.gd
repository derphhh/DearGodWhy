extends Button

# Preload the GameModeSelection scene
var ai_arena = preload("res://Scenes/play_area/AI/AIArena.tscn")
func _ready():
	connect("pressed", self, "_on_PlayButton_pressed")

func _on_PlayButton_pressed():
	get_tree().change_scene_to(ai_arena)

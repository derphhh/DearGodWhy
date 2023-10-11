extends Button  # Change this line

# Preload the MainMenu scene
var main_menu_scene_path = "res://Scenes/main/MainMenu.tscn"

func _ready():
	# Connect the "pressed" signal of this button to our handler
	self.connect("pressed", self, "_on_BackButton_pressed")

func _on_BackButton_pressed():
	# Change to the MainMenu scene when the BackButton is pressed
	get_tree().change_scene(main_menu_scene_path)

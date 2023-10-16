extends Node

func _ready():
	# Connect button press signal to show_profile function.
	connect("pressed", self, "_on_ShowProfileButton_pressed")

func _on_ShowProfileButton_pressed():
	AIProfile.print_aiowned_cards()

extends Button

func _ready():
	# Connect button press signal to show_profile function.
	connect("pressed", self, "_on_display_deck_button_pressed")

func _on_display_deck_button_pressed():
	PlayerProfile.print_deck()

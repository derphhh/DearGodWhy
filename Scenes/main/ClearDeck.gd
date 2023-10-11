# MainScreen.gd
extends Button

func _ready():
	connect("pressed", self, "_on_clear_deck_button_pressed")

func _on_clear_deck_button_pressed():
	PlayerProfile.clear_owned_deck()

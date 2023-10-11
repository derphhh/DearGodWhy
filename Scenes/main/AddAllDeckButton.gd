# MainScreen.gd or wherever your UI is defined
extends Button

func _ready():
	connect("pressed", self, "on_add_deck_button_pressed")

func on_add_deck_button_pressed():
	PlayerProfile.add_all_cards_to_deck()

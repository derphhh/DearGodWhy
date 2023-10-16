# MainScreen.gd or wherever your UI is defined
extends Button

func _ready():
	connect("pressed", self, "_on_assign_cards_button_pressed")

func _on_assign_cards_button_pressed():
	PlayerProfile.assign_cards_1_to_20()

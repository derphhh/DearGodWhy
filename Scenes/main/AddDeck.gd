# MainScreen.gd or wherever your UI is defined
extends Button

func _ready():
	connect("pressed", self, "_on_display_deck_button_pressed")

func _on_display_deck_button_pressed():
	var random_card_id = randi() % 100 + 1  # Generate a random number between 1 and 100
	PlayerProfile.add_card_deck(random_card_id)  # Add the randomly chosen card to the dec

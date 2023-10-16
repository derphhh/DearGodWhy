# MainScreen.gd or wherever your UI is defined
extends Button

func _ready():
	connect("pressed", self, "on_add_deck_button_pressed")

func on_add_deck_button_pressed():
	AIProfile.add_all_aicards_to_aideck()

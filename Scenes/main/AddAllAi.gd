# MainScreen.gd or wherever your UI is defined
extends Button

func _ready():
	connect("pressed", self, "_on_assign_cards_button_pressed")

func _on_assign_cards_button_pressed():
	AIProfile.assign_aicards_1_to_23()

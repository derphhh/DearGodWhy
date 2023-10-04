extends Control
const ADD = 1000

func _ready():
	# Assume you have a button named "BuyCommonPackButton"
	connect("pressed", self, "_on_BuyCommonPackButton_pressed")
func _on_BuyCommonPackButton_pressed():
	PlayerProfile.add_currency(ADD)
		# Logic to award the pack goes here

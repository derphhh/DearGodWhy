extends Node2D

onready var card_name_label : Label = $CardNameLabel
# ... other UI elements ...

func display_card(card):
	card_name_label.text = card.name
	# ... set other fields ...

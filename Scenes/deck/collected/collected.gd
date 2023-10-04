extends Node2D

onready var card_list = $LeftPanel/CardList
onready var displayed_card = $MiddlePanel/DisplayedCard
onready var ability_description = $RightPanel/AbilityDescription

func _ready():
	populate_card_list()

func populate_card_list():
	var owned_cards = PlayerProfile.get_owned_cards()
	for card_id in owned_cards:
		var card_data = load_card_data(card_id)
		card_list.add_item(card_data.card_name)
		
func load_card_data(card_id):
	# Load and return the data for the specified card_id.
	# This may involve fetching data from a file, database, etc.
	# Example:
	return load("res://cards/card_" + str(card_id) + ".tres").resource_name

extends Control  

onready var card_list = $LeftPanel/CardList

func _ready():
	print("Is card_list null?: ", card_list == null)  # Debug Line
	populate_card_list()

func populate_card_list():
	var owned_cards = PlayerProfile.get_owned_cards()
	for card_id in owned_cards:
		var card_data = load_card_data(card_id)
		if card_data:  # Check if card_data is not null
			card_list.add_item(card_data.card_name)

func load_card_data(card_id):
	var path = "res://cards/characters/card_" + str(card_id) + ".tres"
	
	if not ResourceLoader.exists(path):
		print("Error: No resource found at path:", path)
		return null
	
	var card_data = load(path)
	
	print("Loaded card data:", card_data)  # Debug Line
	if card_data and card_data.has_method("get_name"):  # Replace with your method or property
		return card_data.get_name()  # Replace with your method or property
	
	print("Error: Unable to extract name from card_data.")
	return null

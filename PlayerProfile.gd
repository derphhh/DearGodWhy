extends Node

var deck = {}
var owned_cards = {}
signal cards_updated
var currency = 1000  # Starting amount, will be overridden by saved data if available
# Example structure of a deck data
func get_owned_cards():
	return owned_cards
func get_deck():
	return deck
func _ready():
	load_currency()  # Load the saved currency value when the game starts
	load_data()
func add_all_cards_to_deck() -> void:
	if owned_cards == null or deck == null:
		print("Owned cards or deck is not initialized.")
		return
	
	for card_id in owned_cards.keys():
		# Only add the card to the deck if it's not already there
		if not card_id in deck:
			deck[card_id] = 1  # Or another appropriate value
		
	print("All owned cards added to deck.")
	save_data()

func add_currency(amount):
	currency += amount
	save_currency()  # Save the new currency value
func clear_owned_cards():
	owned_cards = {}  # Use {} to create an empty dictionary
	save_data()  # Save the empty owned_cards to file
func clear_owned_deck():
	deck = {}  # Use {} to create an empty dictionary
	save_data()  # Save the empty owned_cards to file
func assign_cards_1_to_23():
	for i in range(1, 101):  # Loop from 1 to 20
		owned_cards[i] = 1  # Assign one of each card
	save_data()  # Save the new owned_cards to file
func assign_cards_deck():
	for i in range(1, 101):  # Loop from 1 to 20
		deck[i] = 1  # Assign one of each card
	save_data()  # Save the new owned_cards to file
func spend_currency(amount):
	if currency >= amount:
		currency -= amount
		save_currency()  # Save the new currency value
		print("Currency spent. New total:", currency)
		return true
	else:
		print("Not enough currency!")
		return false

func save_currency():
	var save_file = ConfigFile.new()  # Create a new ConfigFile instance
	save_file.set_value("player", "currency", currency)  # Set the currency value in the file
	
	# Save the ConfigFile to a path
	var save_path = "user://savegame.save"  # 'user://' writes to user data folder
	var result = save_file.save(save_path)  # Save and capture the result
	if result == OK:  # Check if the save was successful
		print("Game saved successfully!")
	else:
		print("Failed to save game.")

func load_currency():
	var save_file = ConfigFile.new()  # Create a new ConfigFile instance
	var save_path = "user://savegame.save"  # Path to save file
	
	# Load the file and check for errors
	var result = save_file.load(save_path)
	if result == OK:  # If the load was successful
		currency = save_file.get_value("player", "currency", 1000)  # Retrieve the currency value, default to 1000 if not found
		print("Game loaded! Currency: ", currency)
	else:  # If the load failed
		print("Failed to load game.")

# This function will be called automatically when the node is ready

func add_card(card_id: int) -> void:
	if card_id in owned_cards:
		owned_cards[card_id] += 1
	else:
		owned_cards[card_id] = 1
	print("Card", card_id, "added. Total:", owned_cards[card_id])
	
	# Save data every time a card is added
	save_data()
func add_card_deck(card_id: int) -> void:
	if deck == null:
		deck = {}  # Initialize deck if it's null
	
	# Check if card_id is already in the deck
	if card_id in deck:
		print("Card", card_id, "already exists in the deck.")
		return

	# If not, add it to the deck
	deck[card_id] = 1  # Here, 1 can represent that you own this card. You can also use true if you prefer a boolean value.
	
	print("Card", card_id, "added to deck.")
	save_data()

func save_data():
	var file = File.new()
	if file.open("user://player_data.save", File.WRITE) == OK:
		file.store_var(owned_cards)
		file.store_var(deck)
		file.close()
	else:
		print("Could not save the data!")

func load_data():
	var file = File.new()
	if file.file_exists("user://player_data.save"):
		file.open("user://player_data.save", File.READ)
		var loaded_owned_cards = file.get_var()
		var loaded_deck = file.get_var()
		file.close()
		# Type check for loaded data
		if typeof(loaded_owned_cards) == TYPE_DICTIONARY:
			owned_cards = loaded_owned_cards
		else:
			print("Error: Loaded owned cards data is not valid, using an empty dictionary instead.")
			owned_cards = {}
		if typeof(loaded_deck) == TYPE_DICTIONARY:
			deck = loaded_deck
		else:
			print("Error: Loaded deck data is not valid, using an empty dictionary instead.")
			deck = {}
	else:
		print("No saved data!")
		owned_cards = {}
		deck = {}

func print_owned_cards():
	print("Owned Cards: ", owned_cards)
func print_deck():
	print("Deck", deck)

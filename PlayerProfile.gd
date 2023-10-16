extends Node

var owned_cards = {}

var currency = 1000  # Starting amount, will be overridden by saved data if available

func get_owned_cards():
	return owned_cards
func _ready():
	load_currency()  # Load the saved currency value when the game starts
	load_data()
func add_currency(amount):
	currency += amount
	save_currency()  # Save the new currency value
func clear_owned_cards():
	owned_cards = {}  # Use {} to create an empty dictionary
	save_data()  # Save the empty owned_cards to file
func assign_cards_1_to_20():
	for i in range(1, 22):  # Loop from 1 to 20
		owned_cards[i] = 1  # Assign one of each card
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

func save_data():
	var file = File.new()
	if file.open("user://player_data.save", File.WRITE) == OK:
		file.store_var(owned_cards)
		file.close()
	else:
		print("Could not save the data!")

func load_data():
	var file = File.new()
	if file.file_exists("user://player_data.save"):
		file.open("user://player_data.save", File.READ)
		owned_cards = file.get_var()
		file.close()
	else:
		print("No saved data!")
func print_owned_cards():
	print("Owned Cards: ", owned_cards)

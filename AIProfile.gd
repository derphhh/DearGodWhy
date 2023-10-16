extends Node

var aideck = {}
var aiowned_cards = {}
signal cards_updated
func get_ai_owned_cards():
	return aiowned_cards
func get_aideck():
	return aideck
func _ready():
	load_aidata()
func add_all_aicards_to_aideck() -> void:
	if aiowned_cards == null or aideck == null:
		print("Owned cards or deck is not initialized.")
		return
	
	for card_id in aiowned_cards.keys():
		# Only add the card to the deck if it's not already there
		if not card_id in aideck:
			aideck[card_id] = 1  # Or another appropriate value
		
	print("All owned cards added to deck.")
	save_aidata()
func clear_owned_cards():
	aiowned_cards = {}  # Use {} to create an empty dictionary
	save_aidata()  # Save the empty owned_cards to file
func clear_owned_deck():
	aideck = {}  # Use {} to create an empty dictionary
	save_aidata()  # Save the empty owned_cards to file
func assign_aicards_1_to_23():
	for i in range(1, 101):  # Loop from 1 to 20
		aiowned_cards[i] = 1  # Assign one of each card
	save_aidata()  # Save the new owned_cards to file
func assign_aicards_deck():
	for i in range(1, 101):  # Loop from 1 to 20
		aideck[i] = 1  # Assign one of each card
	save_aidata()  # Save the new owned_cards to file


func add_cardai(card_id: int) -> void:
	if card_id in aiowned_cards:
		aiowned_cards[card_id] += 1
	else:
		aiowned_cards[card_id] = 1
	print("Card", card_id, "added. Total:", aiowned_cards[card_id])
	
	# Save data every time a card is added
	save_aidata()
func add_aicard_deck(card_id: int) -> void:
	if aideck == null:
		aideck = {}  # Initialize deck if it's null
	
	# Check if card_id is already in the deck
	if card_id in aideck:
		print("Card", card_id, "already exists in the deck.")
		return

	# If not, add it to the deck
	aideck[card_id] = 1  # Here, 1 can represent that you own this card. You can also use true if you prefer a boolean value.
	
	print("Card", card_id, "added to deck.")
	save_aidata()

func save_aidata():
	var file = File.new()
	if file.open("user://ai_data.save", File.WRITE) == OK:
		file.store_var(aiowned_cards)
		file.store_var(aideck)
		file.close()
	else:
		print("Could not save the data!")

func load_aidata():
	var file = File.new()
	if file.file_exists("user://ai_data.save"):
		file.open("user://ai_data.save", File.READ)
		var loaded_aiowned_cards = file.get_var()
		var loaded_aideck = file.get_var()
		file.close()
		# Type check for loaded data
		if typeof(loaded_aiowned_cards) == TYPE_DICTIONARY:
			aiowned_cards = loaded_aiowned_cards
		else:
			print("Error: Loaded owned cards data is not valid, using an empty dictionary instead.")
			aiowned_cards = {}
		if typeof(loaded_aideck) == TYPE_DICTIONARY:
			aideck = loaded_aideck
		else:
			print("Error: Loaded deck data is not valid, using an empty dictionary instead.")
			aideck = {}
	else:
		print("No saved data!")
		aiowned_cards = {}
		aideck = {}

func print_aiowned_cards():
	print("AI Owned Cards: ", aiowned_cards)
func print_aideck():
	print("AI Deck", aideck)

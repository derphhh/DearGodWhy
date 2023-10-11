extends Node


func check_deck_and_start_game(mode: String) -> void:
	var total_cards = 0
	
	# Sum up all cards in the deck
	for card_count in PlayerProfile.deck.values():
		total_cards += card_count
	
	# Check if total cards are exactly 100
	if total_cards == 100:
		print("Starting game in", mode, "mode!")
		# Here you would put your logic or function call to start the game or switch scene
	else:
		print("Deck must contain exactly 100 cards! Currently: ", total_cards)

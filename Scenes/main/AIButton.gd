extends Button

# Preload the GameModeSelection scene
var ai_arena = preload("res://Scenes/play_area/AI/AIArena.tscn")
func _ready():
	connect("pressed", self, "_on_PlayButton_pressed")
func check_player_deck_and_start_game(mode: String) -> void:
	var total_cards = 0
	for card_count in PlayerProfile.deck.values():
		total_cards += card_count
	if total_cards == 100:
		print("Starting game in ", mode, " mode!")
		get_tree().change_scene_to(ai_arena)
	else:
		print("AI Deck must contain exactly 100 cards! Currently: ", total_cards)
func check_ai_deck_and_start_game(mode: String) -> void:
	var total_cards = 0
	for card_count in AIProfile.aideck.values():
		total_cards += card_count
	if total_cards == 100:
		print("Starting game in ", mode, " mode!")
		get_tree().change_scene_to(ai_arena)
	else:
		print("Deck must contain exactly 100 cards! Currently: ", total_cards)

func _on_PlayButton_pressed():
	check_player_deck_and_start_game("ai")
	check_ai_deck_and_start_game("ai")

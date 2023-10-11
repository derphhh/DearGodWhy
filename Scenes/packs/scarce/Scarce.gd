extends Node2D

var card_scene = preload("res://Scenes/ui/Cards.tscn")
var cards_by_rarity = {
	"Common": [1, 16, 19, 21, 17, 61, 67, 68, 82, 92, 83, 99, 100, 94, 62, 70, 85, 86, 87, 63, 35, 72, 73, 77, 78, 37, 39, 43, 45, 46, 53, 58, 59, 54, 55, 56, 50, 32, 27, 8, 24, 11, 13, 4],
	"Scarce": [2, 10, 12, 20, 31, 26, 33, 7, 91, 64, 65, 40, 84, 71, 41, 49, 74, 75, 28, 52, 48, 29, 5, 23],
	"Rare": [3, 9, 18, 22, 25, 34, 36, 80, 81, 38, 97, 98, 42, 93, 69, 44, 47, 52, 57, 88, 89, 76],
	"Legend": [6, 15, 14, 30, 60, 66, 79, 90, 95, 96]
}
var common_pack_odds = {"Common": 30, "Scarce": 60, "Rare": 8, "Legend": 2}

func _ready():
	randomize()
	var chosen_rarity = decide_card_rarity(common_pack_odds)
	var card_number = choose_card_of_rarity(chosen_rarity)
	
	print("Chosen rarity: ", chosen_rarity, " | Randomly selected card number: ", card_number)
	
	# Add the card number to the player's profile
	PlayerProfile.add_card(card_number)
	
	var card_data = load("res://cards/characters/card_" + str(card_number) + ".tres")
	summon_card(card_data)
# Deciding Card Rarity
func decide_card_rarity(pack_odds):
	var random_value = randf() * 100
	var cumulative_chance = 0
	
	for rarity in pack_odds.keys():
		cumulative_chance += pack_odds[rarity]
		if random_value < cumulative_chance:
			return rarity 

# Choosing a Card of Decided Rarity
func choose_card_of_rarity(rarity):
	var card_list_of_rarity = cards_by_rarity[rarity]
	var random_index = randi() % card_list_of_rarity.size()
	return card_list_of_rarity[random_index] 

func summon_card(card_data):
	var card_instance = card_scene.instance()
	add_child(card_instance)
	card_instance.position = Vector2(100, 100)
	card_instance.set_background(card_data.background)
	card_instance.set_card_name(card_data.card_name)
	card_instance.set_symbol(card_data.symbol)
	card_instance.set_image(card_data.image)
	card_instance.set_health(card_data.health)
	card_instance.set_cost(card_data.cost)
	card_instance.set_ability1(card_data.ability1)
	card_instance.set_ability2(card_data.ability2)
	card_instance.set_type(card_data.card_type)
	card_instance.set_flavorability(card_data.flavor_ability)
	card_instance.set_damage(card_data.damage)

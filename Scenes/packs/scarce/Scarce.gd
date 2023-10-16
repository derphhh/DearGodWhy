extends Node2D

var card_scene = preload("res://Scenes/ui/Cards.tscn")
var cards_by_rarity = {
	"Common": [1, 16, 19, 21, 17, 8, 11, 13, 4],
	"Scarce": [2, 10, 12, 20, 7, 5],
	"Rare": [3, 9, 18],
	"Legend": [6, 15, 14]
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

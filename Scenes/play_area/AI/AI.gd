extends Node2D
var card_data = {}
var countdown_value = 3
var aideck = AIProfile.aideck
var aihand = []
var aigraveyard = []
var card_positions = [Vector2(635, 315), Vector2(740, 315), Vector2(845, 315), Vector2(950, 315), Vector2(1055, 315), Vector2(1160, 315), Vector2(1265, 315) ]
onready var card_scene = preload("res://Scenes/ui/Cards.tscn")
var card_instances = []  # Store references to card instances here
func _ready():
	connect("pressed", self, "_on_AIDrawCardButton_pressed")
	print("AI Initial deck: ", aideck)
func _on_EndTurnButton_pressed():
	$BlockInput.visible = true
func _on_AIDrawCardButton_pressed():
	randomize()
	if aideck.size() > 0 and aihand.size() < 7:
		var card_ids = aideck.keys()
		var chosen_index = randi() % card_ids.size()
		var card_id = card_ids[chosen_index]
		aideck.erase(card_id)
		aihand.append(card_id)
		print("Drew card: ", card_id)

		var card_data = load("res://cards/characters/card_" + str(card_id) + ".tres")
		if card_data:
			summon_card(card_data)
			print("Now deck: ", aideck)
		else:
			print("Failed to summon card due to invalid data")
	else:
		print("No cards left to draw or hand is full!")
func return_ai_cards_to_deck():
	for card_id in aihand:
		if aideck.has(card_id):
			aideck[card_id] += 1
		else:
			aideck[card_id] = 1
	aihand.clear()
func summon_card(card_data):
	var card_instance = card_scene.instance()

	if card_positions.size() > 0:
		var position = card_positions.pop_back()
		card_instance.position = position
	else:
		card_instance.position = Vector2(0, 0)

	add_child(card_instance)
	card_instance.scale = Vector2(0.45, 0.45)
	card_instance.rotation_degrees = 180
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


func _on_BackButton_pressed():
	return_ai_cards_to_deck()

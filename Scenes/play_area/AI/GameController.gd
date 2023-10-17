extends Node2D
var card_data = {}
var countdown_value = 3
var deck = PlayerProfile.deck
var hand = []
var battlefield = []
var graveyard = []
var card_positions = [ Vector2(400, 265), Vector2(295, 265), Vector2(190, 265), Vector2(85, 265), Vector2(-20, 265), Vector2(-125, 265), Vector2(-230, 265)]
onready var card_scene = preload("res://Scenes/ui/Cards.tscn")

func _ready():
	$EndTurnButton.connect("pressed", self, "_on_EndTurnButton_pressed")
	connect("pressed", self, "_on_DrawCardButton_pressed")
	$CountdownLabel.text = str(countdown_value)
	$BlockInput.visible = true
	$CountdownTimer.start()
func _on_AIEndTurnButton_pressed():
	$BlockInput.visible = true
func _on_DrawCardButton_pressed():
	randomize()
	if deck.size() > 0 and hand.size() < 7:
		var card_ids = deck.keys()
		var chosen_index = randi() % card_ids.size()
		var card_id = card_ids[chosen_index]
		deck.erase(card_id)
		hand.append(card_id)
		print("Drew card: ", card_id)
		var card_data = load("res://cards/characters/card_" + str(card_id) + ".tres")
		if card_data:
			summon_card(card_data)
		else:
			print("Failed to summon card due to invalid data")
	else:
		print("No cards left to draw or hand is full!")
func return_cards_to_deck():
	for card_id in hand:
		if deck.has(card_id):
			deck[card_id] += 1
		else:
			deck[card_id] = 1
	hand.clear()
func summon_card(card_data):
	print("Summoning card...")
	var card_instance = card_scene.instance()  # Create a new card_instance
	print("Connecting signal...")
	card_instance.connect("card_clicked", self, "_on_card_clicked")  # Connect the signal here

	print("Signal connected.")
	if card_positions.size() > 0:
		var position = card_positions.pop_back()
		card_instance.position = position
	else:
		card_instance.position = Vector2(0, 0)
	add_child(card_instance)
	card_instance.scale = Vector2(0.45, 0.45)
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
func _on_CountdownTimer_timeout():
	countdown_value -= 1
	if countdown_value > 0:
		$CountdownLabel.text = str(countdown_value)
	else:
		game_start()
func game_start():
	$CountdownTimer.stop()
	$CountdownLabel.text = "Game Start!"
	$StartDisplayTimer.start()

func _on_StartDisplayTimer_timeout():
	$CountdownLabel.visible = false
	$BlockInput.visible = false
func _on_BackButton_pressed():
	return_cards_to_deck()
func _on_card_clicked(card_instance):
	print("Signal received. Checking...")
	var card_id = card_instance.card_id
	print("Card ID from clicked card: ", card_id)
	print("Current hand: ", hand)
	if card_id in hand:
		hand.erase(card_id)
		battlefield.append(card_id)
		print("Moved card from hand to battlefield.")
	else:
		print("Card ID not found in hand.")

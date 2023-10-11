extends Node2D

var card_data = {}
var countdown_value = 3

func _ready():
	connect("pressed", self, "_on_DrawCardButton_pressed")
	$CountdownLabel.text = str(countdown_value)
	# Block player input at the start
	$BlockInput.visible = true
	# Start the countdown timer
	$CountdownTimer.start()
func _on_DrawCardButton_pressed():
	randomize()  # Ensure the RNG is randomized
	# Obtain the deck from the player rofile
	var deck = PlayerProfile.get_deck()
	# Choose a random index and card ID from the deck
	var chosen_card_id = deck.keys()[randi() % deck.size()]
	# Debugging: Print the chosen index and card ID
	print("Randomly selected card number: ", chosen_card_id)
	# Fetch card data using the chosen ID
	var card_data = load("res://cards/characters/card_" + str(chosen_card_id) + ".tres")
	# Ensure the card data is valid
	if card_data:
		summon_card(card_data)
	else:
		print("Failed to summon card due to invalid data")

func _on_CountdownTimer_timeout():
	countdown_value -= 1
	if countdown_value > 0:
		$CountdownLabel.text = str(countdown_value)
	else:
		game_start()

func game_start():
	$CountdownTimer.stop()
	$CountdownLabel.text = "Game Start!"
	$StartDisplayTimer.start()  # Start the timer

func _on_StartDisplayTimer_timeout():
	# Unblock player input and hide the countdown label after the timer ends
	$CountdownLabel.visible = false
	$BlockInput.visible = false
var card_scene = preload("res://Scenes/ui/Cards.tscn")
func summon_card(card_data):
	var card_instance = card_scene.instance()
	add_child(card_instance)
	card_instance.position = Vector2(0, 0)
	card_instance.scale = Vector2(0.5 , 0.5)
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

extends Control
var deck = []
var card_scene = preload("res://Scenes/ui/Cards.tscn")
var custom_font = preload("res://assets/fonts/comicSans.tres")
var deck_card_ids = PlayerProfile.decks["default"]  # Get cards in the default deck
	
func _ready():
	populate_buttons(PlayerProfile.get_owned_cards())
	update_deck_display()
	var owned_card_ids = PlayerProfile.get_owned_cards()  # Existing line
	var deck_card_ids = PlayerProfile.decks["default"]  # Get cards in the default deck
	
	# Convert keys to an array and sort them
	var card_id_array = []
	for card_id in owned_card_ids.keys():
		card_id_array.append(int(card_id))  # Assuming the keys are strings of integers
	
	card_id_array.sort()
	
	# Populate respective containers
	for card_id in card_id_array:
		if card_id in deck_card_ids:
			add_card_to_deck(card_id, $ScrollContainer2/VBoxContainer2, null)
		else:
			add_card_to_available(card_id, $ScrollContainer/VBoxContainer)

	update_deck_display()

# Other functions remain the same...

# Updated the following function to accept a parent argument
func add_card_to_available(card_id, parent):
	# Get the container for the available cards
	var available_cards_container = parent if parent else $ScrollContainer/VBoxContainer
	
	var card_data = load_card_data(card_id)
	if card_data:
		# Create a new HBoxContainer for the available card UI
		var hbox = HBoxContainer.new()
		available_cards_container.add_child(hbox)
		# Create and configure card button FIRST
		var card_btn = Button.new()
		card_btn.text = card_data.card_name 
		card_btn.connect("pressed", self, "_on_CardButton_pressed", [card_id])
		card_btn.add_font_override("font", custom_font)
		card_btn.rect_min_size = Vector2(200, 50)
		hbox.add_child(card_btn)

		# Create and configure '+' button SECOND
		var plus_btn = Button.new()
		plus_btn.text = "+"
		plus_btn.rect_min_size = Vector2(50, 50)
		# Now card_btn is already defined when we connect plus_btn
		plus_btn.connect("pressed", self, "_on_PlusButton_pressed", [card_id, hbox, card_btn])
		hbox.add_child(plus_btn) 
		plus_btn.add_font_override("font", custom_font)


func _on_AddButton_pressed(card_id):
	print("Adding card:", card_id, "to deck")
	PlayerProfile.add_card_to_deck("default", card_id)  # Using the 'default' deck as an example
	update_deck_display()

func _on_RemoveButton_pressed(card_id, hbox):
	print("Removing card:", card_id, "from deck")
	PlayerProfile.remove_card_from_deck("default", card_id)  # Using the 'default' deck as an example
	update_deck_display()
	add_card_to_available("default", card_id)
func update_deck_display():
	# Ensure the VBoxContainer2 node is available and clear it
	var deck_container = $ScrollContainer2/VBoxContainer2
	if deck_container:
		# Clear the current UI
		for child in deck_container.get_children():
			child.queue_free()
	else:
		print("Error: Could not find $Main/ScrollContainer2/VBoxContainer2")
	
	for card_id in deck:
		# Ensure the node exists before attempting to create UI
		if deck_container:
			var hbox = HBoxContainer.new()
			deck_container.add_child(hbox)
			var card_name = get_card_name(card_id)
			
			# Add a Button to display the card name and when clicked, show the card
			var card_button = Button.new()
			card_button.text = card_name
			card_button.connect("pressed", self, "_on_DeckCardButton_pressed", [card_id])
			hbox.add_child(card_button)
			card_button.add_font_override("font", custom_font)
			card_button.rect_min_size = Vector2(200, 50)  # To ensure similar size with other buttons
			
			# Add a Button to remove the card from the deck
			var remove_button = Button.new()
			remove_button.text = "-"
			hbox.add_child(remove_button)
			remove_button.connect("pressed", self, "_on_RemoveButton_pressed", [card_id, hbox])
			remove_button.add_font_override("font", custom_font)
		else:
			print("Error: Could not find $Main/ScrollContainer2/VBoxContainer2")

# A method to handle showing the card when the card name button is pressed
func _on_DeckCardButton_pressed(card_id):
	print("Card button in deck", card_id, "pressed")
	
	# Obtain the card data
	var card_data = load_card_data(card_id)
	if card_data:
		summon_card(card_data)
	
	# ...Rest of your logic if needed


func populate_buttons(owned_card_ids):
	var available_cards_container = $ScrollContainer/VBoxContainer  # Left side (adjust as per your structure)
	var deck_container = $ScrollContainer2/VBoxContainer2  # Right side (adjust as per your structure)

	# Clear previous buttons.
	for child in available_cards_container.get_children():
		child.queue_free()
	for child in deck_container.get_children():
		child.queue_free()
	
	for card_id in owned_card_ids:
		if card_id in PlayerProfile.decks["default"]:
			# add card to deck (right side)
			add_card_to_deck(card_id, deck_container, null)
		else:
			# add card to available (left side)
			add_card_to_available(card_id, available_cards_container)

func load_card_data(card_id):
	var path = "res://cards/characters/card_" + str(card_id) + ".tres"
	if ResourceLoader.exists(path):
		var card_data = load(path)
		return card_data
	else:
		print("Error: No card data found at path:", path)
		return null

func _on_SearchBar_text_changed():
	filter_buttons($LineEdit.text.strip())

func filter_buttons(search_text):
	for hbox in $ScrollContainer/VBoxContainer.get_children():
		hbox.visible = search_text in hbox.get_child(1).text

func _on_PlusButton_pressed(card_id, hbox, card_btn):
	print("Plus button pressed for card: ", card_btn.text)
	add_card_to_deck(card_id, hbox, card_btn)

func add_card_to_deck(card_id, hbox, card_btn):
	# Print out the name of the card being removed
	print("Removing card: ", card_btn.text)

	deck.append(card_id)  # Add the card to your deck array
	update_deck_display()  # Update the UI to reflect the change in the deck
	
	# Remove the UI elements for this card from the available cards UI
	hbox.queue_free()  


func _on_CardButtonInDeck_pressed(card_id):
	print("Card button in deck with ID", card_id, "pressed")
	# Add additional functionality here if desired

func get_card_name(card_id):
	var card_data = load_card_data(card_id)
	if card_data:
		return card_data.card_name
	else:
		print("Error: No card data found for card_id:", card_id)
		return ""  # Or handle this in a way that makes sense for your use case

func _on_CardButton_pressed(card_id):
	print("Card button", card_id, "pressed")
	
	# Obtain the card data
	var card_data = load_card_data(card_id)
	if card_data:
		summon_card(card_data)
	
	# Get the owned card counts from the PlayerProfile
	var owned_cards = PlayerProfile.get_owned_cards()
	
	# Ensure the card_id is available in the owned_cards and print the count
	if card_id in owned_cards:
		print("You have ", owned_cards[card_id], " of card ", card_id)
	else:
		print("Card", card_id, "not found in owned cards!")

func summon_card(card_data):
	var card_instance = card_scene.instance()
	add_child(card_instance)
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
	if has_node("DisplayedCard"):
		get_node("DisplayedCard").queue_free()
	card_instance.name = "DisplayedCard"  # Set a recognizable name for easier access
	
	# Configure the card using your methods (add these methods to your card scene/script)
	card_instance.set_image(card_data.image)  # Hypothetical method to set image
	card_instance.set_card_name(card_data.card_name)    # Hypothetical method to set name

	# [4] Add the card instance to your scene
	add_child(card_instance)
	card_instance.scale = Vector2(2, 2)  # Scale to be twice the original size
	card_instance.position = Vector2(-1000, -500)

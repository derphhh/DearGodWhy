extends Control
var card_scene = preload("res://Scenes/ui/Cards.tscn")
var custom_font = preload("res://assets/fonts/comicSans.tres")
var ability_descriptions = {
	"Rage": "Character has to attack every turn",
	"Healing": "+0/+100 Every turn",
	"Poison": "-0/-100 towards target character every turn for two turns",
	"Deathless": "Upon death the card is shuffled back into the deck",
	"Super Speed": "Character attacks twice in one turn",
	"Flame": "-0/-100 towards target character every turn for two turns",
	"Flight": "Character can attack any card or player on the board, can only be blocked by a card with flying or deadeye",
	"Sorcery": "I haven't decided",
	"Consume": 'Copy all cards abilities on the battlefield',
	"Meme": "WIP",
	"Dodge": "Dodges an attack",
	"Parry": "Dodges attack and reflects damage back",
	"Sassy": "Chosen opponent character has to attack this card",
	"One For All": "WIP",
	"Teleportation": "Hits a character card no matter what, unless card has flight",
	"Light Side": "WIP",
	"Size-Manipulation": "Adds +200/+200 for 2 turns",
	"Recall": "Draw a card",
	"Disintegration": "Instantly kill a character card",
	"Transmutation": "Sacrifice a card from your hand or battlefield and draw a card",
	"Deadeye": "Hits a target no matter what",
	"Block": "Blocks an attack",
	"Freeze": "Character card is unable to do anything for 2 turns",
	"Blackhole": "Remove all item and ability cards from opponents hand and board",
	"Sabotage": "Pick an opponents item card, it is now unable to do anything",
	"Steal": "Take an opponents item or ability card",
	"Power Nullification": "Remove an oponents abilities from a character card",
	"Resource Drain": "Take an opponents abilities from a character card",
	"Electrokinesis": "Chosen character card is unable to do anything for a turn",
	"Stun": "Stun an opponents character card",
	"Speedforce": "WIP",
	"Invisibility": "Character card is unable to be attacked for one turn",
	"Shield": "Applies a 0/200 shield",
	"Time Manipulation": "Revive a fallen character that has died in the last two turns",
	"Reach": "Can attack flying characters",
	"Dark Side": "WIP",
	"Symbiosis": "Combine this card with another, health, damage, abilities and all",
	"Insanity": "Opponents character card is unable to do anything",
	"Drain": "The amount of damage you do is the amount of healthh added to this card",
	"Intangibility": "Character card is unable to be harmed or attack but can still use abilities",
	"Bloodlust": "The amount of damage taken is the amount of damage dealt plus the damage the card already has",
	"Wizardry": "WIP",
	"Branding": "If a character is killed by this card, you take possesion of this card for the remainder of the game",
	"Imbue": "Add a power to an item card",
	"Copy": "Copy any card on the battlefield"
}

func _ready():
	$LineEdit.connect("text_changed", self, "_on_SearchBar_text_changed")
	var owned_card_ids = PlayerProfile.get_owned_cards()  # Hypothetical function
	
	# Convert keys to an array and sort them
	var card_id_array = []
	for card_id in owned_card_ids.keys():
		card_id_array.append(int(card_id))  # Assuming the keys are strings of integers
	
	card_id_array.sort()
	
	populate_buttons(card_id_array)

func populate_buttons(owned_card_ids):
	for card_id in owned_card_ids:
		var btn = Button.new()
		
		# Load the card data
		var card_data = load_card_data(card_id)
		
		# If card_data is valid, use its name for the button text
		if card_data:
			btn.text = card_data.card_name  # Assuming 'card_name' property exists
			btn.connect("pressed", self, "_on_Button_pressed", [card_id])
			btn.add_font_override("font", custom_font)  # Apply the custom font to the button
			$ScrollContainer/VBoxContainer.add_child(btn)
		btn.rect_min_size = Vector2(200, 50)  # Width x Height in pixels
func load_card_data(card_id):
	# Correcting the path, as it seems there was an error in the previous path
	var path = "res://cards/characters/card_" + str(card_id) + ".tres"
	var ability_descriptions = {
	"Rage": "Character has to attack every turn",
	"Healing": "+0/+100 Every turn",
	"Poison": "-0/-100 towards target character every turn",
	#... (more abilities and descriptions)
}

	if ResourceLoader.exists(path):
		var card_data = load(path)
		return card_data
	else:
		print("Error: No card data found at path:", path)
		return null

func _on_SearchBar_text_changed():
	filter_buttons($LineEdit.text.strip())

func filter_buttons(search_text):
	for btn in $ScrollContainer/VBoxContainer.get_children():
		btn.visible = search_text in btn.text

# ... (rest of your script)

func _on_Button_pressed(card_id):
	print("Button for card", card_id, "pressed")
	var card_data = load_card_data(card_id)
	if card_data:
		summon_card(card_data)
		
		# Update abilities on UI labels
		display_abilities_on_UI(card_data)

func display_abilities_on_UI(card_data):
	# Check and display Ability 1
	if card_data.ability1 and card_data.ability1 in ability_descriptions:
		$Ability1.text = "Ability 1: " + card_data.ability1 + " - " + ability_descriptions[card_data.ability1]
	else:
		$Ability1.text = "Ability 1: N/A"
	
	# Check and display Ability 2
	if card_data.ability2 and card_data.ability2 in ability_descriptions:
		$Ability2.text = "Ability 2: " + card_data.ability2 + " - " + ability_descriptions[card_data.ability2]
	else:
		$Ability2.text = "Ability 2: N/A"
	
	# Check and display Flavor Ability
	if card_data.flavor_ability and card_data.flavor_ability in ability_descriptions:
		$FlavorAbility.text = "Flavor Ability: " + card_data.flavor_ability + " - " + ability_descriptions[card_data.flavor_ability]
	else:
		$FlavorAbility.text = "Flavor Ability: N/A"
func print_abilities(card_data):
	print("Abilities for ", card_data.card_name, ":")
	print("Ability 1:", card_data.ability1)
	print("Ability 2:", card_data.ability2)
	print("Flavor Ability:", card_data.flavor_ability)
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



extends Node2D

var card_positions = []
var center_position = Vector2(400, 300)  # Adjust this to your desired center position
var card_spacing = 100  # Horizontal space between cards

# On _ready or wherever you initialize your scene, set up the initial positions
func _ready():
	card_positions.append(center_position)

# When drawing a card
func draw_card():
	var card_instance = load("res://Scenes/ui/Cards.tscn").instance()
	
	# Determine the position based on the current number of cards
	var position = determine_position(card_positions.size())
	
	card_instance.position = position
	$HandArea.add_child(card_instance)
	card_positions.append(position)

func determine_position(card_count):
	if card_count == 0:
		return center_position
	elif card_count % 2 == 0:
		# For even numbers, place to the right of the center
		return center_position + Vector2(card_spacing * (card_count / 2), 0)
	else:
		# For odd numbers, place to the left of the center
		return center_position - Vector2(card_spacing * ceil(card_count / 2.0), 0)

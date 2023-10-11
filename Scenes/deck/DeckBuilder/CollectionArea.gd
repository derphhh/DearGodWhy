extends ScrollContainer  # Assuming this script is attached to the VBoxContainer under CollectionArea
signal card_selected(card_data)
# Assuming user_profile stores owned_card_ids, and each ID corresponds to a card resource.
onready var player_profile: PlayerProfile = preload("res://PlayerProfile.gd").instance()

func _ready():
	update_collection_buttons()

func update_collection_buttons():
	for child in get_children():
		child.queue_free()
	
	for card_id in player_profile.owned_card_ids:
		var button = Button.new()
		button.text = "Card " + str(card_id)
		button.connect("pressed", self, "_on_card_button_pressed", [card_id])
		add_child(button)

func _on_card_button_pressed(card_id):
	var card_data = load("res://cards/characters/card_" + str(card_id) + ".tres")
	emit_signal("card_selected", card_data)


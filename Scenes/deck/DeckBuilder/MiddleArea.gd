extends VBoxContainer

var card_scene = preload("res://Scenes/ui/Cards.tscn")

func _ready():
	# Assuming CollectionArea is a sibling node in the scene tree
	get_parent().get_node("CollectionArea").connect("card_selected", self, "summon_card")

func summon_card(card_data):
	for child in get_children():
		child.queue_free()
	
	var card_instance = card_scene.instance()
	add_child(card_instance)
	# Adjust position if necessary
	card_instance.position = Vector2(100, 100)
	
	# Set properties...
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

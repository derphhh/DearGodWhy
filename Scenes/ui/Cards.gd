extends Node2D

onready var card_name_label = $Control/CardName  # Adjust path accordingly
onready var background = $Control/Background
onready var symbol = $Control/Symbol
onready var cost = $Control/cost
onready var image = $Control/Image
onready var type = $Control/Type
onready var ability1 = $Control/Ability1
onready var ability2 = $Control/Ability2
onready var flavorability = $Control/FlavorAbility
onready var damage = $Control/Damage
onready var health = $Control/Health

func set_background(new_background):
	background.texture = new_background
func set_card_name(new_name : String):
	card_name_label.text = new_name
func set_symbol(new_texture):
	symbol.texture = new_texture
func set_image(new_image):
	image.texture = new_image
func set_type(new_type : String):
	type.text = new_type
func set_ability1(new_ability1 : String):
	ability1.text = new_ability1
func set_ability2(new_ability2 : String):
	ability2.text = new_ability2
func set_flavorability(new_flavorability : String):
	flavorability.text = new_flavorability
func set_health(new_health : int):
	health.text = str(new_health) 
func set_damage(new_damage : int): 
	damage.text = str(new_damage)
func set_cost(new_cost : int):
	cost.text = str(new_cost)

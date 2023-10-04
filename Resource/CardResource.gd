# CardData.gd
extends Resource
class_name CardData

export(int) var id
export(String) var card_name
export(Texture) var image
export(int) var cost
export(String) var card_type  # Ensure you use `card_type`, not `type`
export(String) var ability1
export(String) var ability2
export(String) var flavor_ability  # Ensure you use `flavor_ability`, not `flavorability`
export(int) var damage
export(int) var health
export(Texture) var symbol
export(Texture) var background

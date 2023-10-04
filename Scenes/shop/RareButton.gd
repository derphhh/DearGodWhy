extends Control

const RARE_PACK_COST = 500

# Preload the GameModeSelection scene
var card_display_scene = preload("res://Scenes/packs/rare/Rare.tscn")

func _ready():
	# Assuming you have a button named "BuyCommonPackButton" in the scene tree.
	connect("pressed", self, "_on_BuyCommonPackButton_pressed")

func _on_BuyCommonPackButton_pressed():
	if PlayerProfile.spend_currency(RARE_PACK_COST):
		# Logic to award the pack goes here
		print("Pack Purchased!")
		# Switch to the new scene.
		get_tree().change_scene_to(card_display_scene)
	else:
		# Optionally, inform the player about the failed purchase via UI/Print.
		print("Purchase failed. Not enough currency.")

extends Control

const COMMON_PACK_COST = 100

# Preload the GameModeSelection scene
var card_display_scene = preload("res://Scenes/packs/common/Display.tscn")

func _ready():
	# Assuming you have a button named "BuyCommonPackButton" in the scene tree.
	connect("pressed", self, "_on_BuyCommonPackButton_pressed")

func _on_BuyCommonPackButton_pressed():
	if PlayerProfile.spend_currency(COMMON_PACK_COST):
		# Logic to award the pack goes here
		print("Pack Purchased!")
		# Switch to the new scene.
		get_tree().change_scene_to(card_display_scene)
	else:
		# Optionally, inform the player about the failed purchase via UI/Print.
		print("Purchase failed. Not enough currency.")

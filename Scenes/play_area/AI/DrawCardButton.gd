extends Button

# Path to the card scene
var card_scene = preload("res://Scenes/ui/Cards.tscn")
var press_count = 0  # to keep track of button presses
var positions = [Vector2(90, 400), Vector2(190, 400), Vector2(290, 400), Vector2(390,400), Vector2(490,400), Vector2(590,400), Vector2(690,400)]  # positions for cars
onready var game_controller = get_tree().root.get_node("GameController")

func _ready():
	connect("pressed", self, "_on_DrawCardButton_pressed")

func _on_DrawCardButton_pressed():
	print("Button pressed")
	if press_count >= positions.size():
		print("All positions are filled!")
		return

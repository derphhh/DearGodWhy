extends Node2D

var card_data = {}
var countdown_value = 3

func _ready():
	print("GameController is ready")
	$CountdownLabel.text = str(countdown_value)
	
	# Block player input at the start
	$BlockInput.visible = true
	
	var file = File.new()
	file.open("res://Scripts/cards/cards.json", File.READ)
	card_data = parse_json(file.get_as_text())
	file.close()
	
	# Start the countdown timer
	$CountdownTimer.start()

# Function that gets called every time the timer times out (every second)
func _on_CountdownTimer_timeout():
	countdown_value -= 1
	if countdown_value > 0:
		$CountdownLabel.text = str(countdown_value)
	else:
		game_start()

func game_start():
	$CountdownTimer.stop()
	$CountdownLabel.text = "Game Start!"
	$StartDisplayTimer.start()  # Start the timer

func _on_StartDisplayTimer_timeout():
	# Unblock player input and hide the countdown label after the timer ends
	$CountdownLabel.visible = false
	$BlockInput.visible = false
func get_card_data_by_id(id):
	print("Getting card data for id:", id)
	for card in card_data["cards"]:  # Don't forget to use ["cards"] to access the array within your JSON.
		if card["id"] == id:
			return card
	return null

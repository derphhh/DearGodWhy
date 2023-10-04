extends Node2D

var cards : Array = []
var cards_data = []

func _ready():
	shuffle()
	load_cards_from_json()
	
func shuffle():
	cards.shuffle()

func load_cards_from_json():
	var file = File.new()
	if file.file_exists("res://Scripts/data/cards.json"):
		file.open("res://Scripts/data/cards.json", File.READ)
		var data = parse_json(file.get_as_text())
		cards_data = data["cards"]
		file.close()

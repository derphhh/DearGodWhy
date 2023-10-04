extends Node

var card_data = {}

func _ready():
	load_card_data()

func load_card_data():
	var file = File.new()
	if file.file_exists("res://Scripts/data/cards.json"):
		file.open("res://Scripts/data/cards.json", File.READ)
		card_data = parse_json(file.get_as_text())
		file.close()

extends Node2D

var cards : Array = []

func _ready():
	shuffle_deck()

func shuffle_deck():
	cards.shuffle()

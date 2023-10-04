extends Node2D

onready var currency_label = $Control/CanvasLayer/HBoxContainer/Currency/CurrencyLabel


func update_currency_display():
	# Ensure that currency_label and PlayerProfile are not null
	if currency_label and PlayerProfile:
		currency_label.text = "Currency: " + str(PlayerProfile.currency)
	else:
		print("Error: Node not found!")

func _ready():
	update_currency_display()



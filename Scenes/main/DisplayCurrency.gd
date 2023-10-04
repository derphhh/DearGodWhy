extends Control

onready var currency_label = $CanvasLayer/HBoxContainer/CurrencyLabel/CurrencyLabel

func _ready():
	# Ensure the update function is called once all nodes are fully initialized.
	call_deferred("update_currency_display")

func update_currency_display():
	if currency_label != null:  # Extra check to ensure currency_label is not null
		currency_label.text = "Currency: " + str(PlayerProfile.currency)
	else:
		print("Error: currency_label is null!")

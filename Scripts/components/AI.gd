extends Node2D

func choose_card_to_play(hand):
	if hand.size() > 0:
		return hand[randi() % hand.size()]
	else:
		return null

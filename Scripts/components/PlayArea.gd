extends Node2D

var player_hand : Array = []
var ai_hand : Array = []

func draw_card(player_deck, hand):
	if player_deck.cards.size() > 0:
		var card = player_deck.cards.pop_front()
		hand.append(card)

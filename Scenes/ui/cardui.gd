extends Control

var original_scale

func _ready():
	original_scale = self.rect_min_size

func _on_Card_mouse_entered():
	# Scale the card when the mouse enters
	self.rect_min_size = original_scale * 1.2

func _on_Card_mouse_exited():
	# Restore the original scale when the mouse exits
	self.rect_min_size = original_scale

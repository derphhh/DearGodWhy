extends Control
signal card_clicked(card_instance)
var target_position = Vector2(860, -100)  # Set this to wherever you want the card to move to

func _ready():
	connect("mouse_entered", self, "_on_mouse_entered")
	connect("mouse_exited", self, "_on_mouse_exited")
	connect("gui_input", self, "_on_gui_input")  # Connect GUI input to handle clicks

func _on_gui_input(event):
	if get_tree().current_scene.filename == "res://Scenes/play_area/AI/AIArena.tscn":
		if event is InputEventMouseButton:
			if event.button_index == BUTTON_LEFT and event.pressed:
				rect_position = target_position
				emit_signal("card_clicked", self)
				print("Signal Emitted")
# Reference to the highlight node, assuming it's a child node named "Highlight"
onready var highlight = $Outline

func _on_mouse_entered():
	if get_tree().current_scene.filename == "res://Scenes/play_area/AI/AIArena.tscn":
		highlight.visible = true

func _on_mouse_exited():
	if get_tree().current_scene.filename == "res://Scenes/play_area/AI/AIArena.tscn":
		highlight.visible = false

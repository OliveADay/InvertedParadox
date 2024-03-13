extends Control

var Camera = Camera2D

# Called when the node enters the scene tree for the first time.
func _ready():
	Camera = get_tree().get_first_node_in_group("Camera") # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = Camera.get_screen_center_position()

extends Timer

var pastVisible = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if get_parent().visible and not pastVisible:
		start(4)
		
		
	pastVisible = get_parent().visible


func _on_timeout():
	get_parent().visible = false # Replace with function body.

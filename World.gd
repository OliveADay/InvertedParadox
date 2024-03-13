extends Node2D

var L2 = preload("res://L2.tscn").instantiate()
var L3 = preload("res://L3.tscn").instantiate()
var L4 = preload("res://L4.tscn").instantiate()
var L5 = preload("res://L5.tscn").instantiate()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _Trans_1_2(lev):
	if(lev == 1):
		add_child(L2)
		$L1.queue_free()
	if(lev == 2):
		add_child(L3)
		$L2.queue_free()
	if(lev == 3):
		add_child(L4)
		$L3.queue_free()
	if(lev == 4):
		add_child(L5)
		$L4.queue_free()

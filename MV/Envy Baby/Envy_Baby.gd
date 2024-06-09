extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	DscCommand.set_chart_base($Chart)
	DscCommand.TARGET(1, 372000, 60000, 178000, 300000, 500, -2)
	DscCommand.TARGET(1, 324000, 60000, 176000, 350000, 500, -2)
	DscCommand.TARGET(1, 300000, 60000, 175000, 400000, 500, -2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

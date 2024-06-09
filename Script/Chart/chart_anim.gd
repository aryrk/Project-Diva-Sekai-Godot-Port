extends Sprite2D

var flying_sprite : Sprite2D
var timer = Timer.new()
var move_speed = 800 # Kecepatan perpindahan per detik

func setup(flying_node : Sprite2D):
	flying_sprite = flying_node
	
	super.add_child(timer)
	
	timer.autostart = true
	timer.wait_time = 0.01
	timer.start()
	timer.connect("timeout", _on_timer_timeout)
	
func _on_timer_timeout():
	if flying_sprite.position != position:
		print(flying_sprite.position, " | ", position)
		var direction = (position - flying_sprite.position).normalized()
		var step = direction * move_speed * timer.wait_time
		if flying_sprite.position.distance_to(position) < step.length():
			flying_sprite.position = position
		else:
			flying_sprite.position += step
	else:
		flying_sprite.visible = false
		visible = false

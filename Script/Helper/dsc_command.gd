extends Node

var chart_base :Control
var chart_res
var chart_script = load("res://Script/Chart/chart_anim.gd")

func set_chart_base(chart):
	chart_base = chart
	chart_res = chart_base.size

func TARGET(type, x,y,angle,distance,amplitude,wavecount):
	var x_target = (x*0.002666667)/1280
	var y_target = (y*0.002666667)/720
	var target_distance = (distance*0.002666667)
	
	var Target_btn : Sprite2D = Sprite2D.new()
	Target_btn.texture = load("res://Sprite/target_circle.svg")
	
	Target_btn.position = Vector2(chart_res[0]*x_target, chart_res[1]*y_target)
	
	var Target_flying : Sprite2D = Sprite2D.new()
	Target_flying.texture = load("res://Sprite/icon_circle.svg")
	
	Target_flying.position = Vector2((chart_res[0]*x_target)+(target_distance), (chart_res[1]*y_target)+(target_distance))
	
	Target_btn.scale = Vector2(0.5,0.5)
	Target_flying.scale = Vector2(0.5,0.5)
	
	chart_base.add_child(Target_btn)
	chart_base.add_child(Target_flying)
	
	Target_btn.set_script(chart_script)
	Target_btn.setup(Target_flying)

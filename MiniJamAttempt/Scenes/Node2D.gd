extends Node2D





func _on_Area2D_body_entered(body):
	if body.is_in_group("planet"):
		$Polygon2D.visible = false
		$Polygon2D2.visible = true
		$Line2D.visible = false
		get_parent().shooting = false


func _on_Area2D_body_exited(body):
	if body.is_in_group("planet"):
		$Polygon2D.visible = true
		$Polygon2D2.visible = false
		$Line2D.visible = true
		get_parent().shooting = true
		

extends KinematicBody2D



var vel = Vector2()
var speed = 300


func _ready():
	set_as_toplevel(true)
	#$Particles2D.emitting = false

func _physics_process(delta):
	
	look_at(Vector2(512, 312))
	
	vel += transform.x * speed
	
	move_and_slide(vel)



func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		body.lives -= 1
		queue_free()


func _on_Timer_timeout():
	queue_free()

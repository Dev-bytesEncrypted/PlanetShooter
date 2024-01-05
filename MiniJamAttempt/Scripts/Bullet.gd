extends KinematicBody2D

var vel = Vector2()
var speed = 200
var parent
var hit_planet = false

func _ready():
	set_as_toplevel(true)
	#look_at(get_viewport().get_mouse_position())
	$Particles2D.emitting = false
	
	
	if parent == "enemy":
		$Area2D/CollisionShape2D.shape.radius = 20

func _physics_process(delta):
	
	if parent == "enemy" and hit_planet == false:
		vel = Vector2.ZERO
		
		look_at(Vector2(512, 312))
	
		vel += transform.x * speed
		
		move_and_slide(vel)
		
	if parent == "player" and hit_planet == false:
	
		move_and_slide(vel*speed*delta)
	
	if hit_planet == true:
		vel = Vector2.ZERO
		move_and_slide(vel)


func _on_Area2D_body_entered(body):
	if body.is_in_group("planet"):
		$Polygon2D.visible = false
		$Particles2D.emitting = true
		hit_planet = true
		#$Area2D/CollisionShape2D.disabled = true
		$Timer.start(1)
		#queue_free()
		
	if body.is_in_group("enemy") and parent == "player":
		#body.queue_free()
		body.dead = true
		#var parent = get_tree().get_root().get_parent().get_child(4)
		#parent.lives += 1
		$Polygon2D.visible = false
		$Particles2D.emitting = true
		hit_planet = true
		#$Area2D/CollisionShape2D.disabled = true
		$Timer.start(1)
		#queue_free()
	
	if body.is_in_group("player") and parent == "enemy":
		#body.queue_free()
		#get_parent().lives -= 1
		get_parent().remove_tree = true
		#var parent = get_tree().get_root().get_parent().get_child(4)
		#parent.lives += 1
		$Polygon2D.visible = false
		$Particles2D.emitting = true
		$Timer.start(1)
		#queue_free()
		
		



func _on_Timer_timeout():
	queue_free()


func _on_Despawn_timeout():
	queue_free()

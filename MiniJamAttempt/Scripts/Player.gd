extends KinematicBody2D


var velocity = Vector2()
var speed = 200
var fall_accl = 10
var left = false
onready var bullet_scene = preload("res://Scenes/Bullet.tscn")
var ammo = 7
var lives = 1
var on_ground = false
var mouse_sens = 0.01
var shooting = true
var crashed = false

func get_input():
	
	#$Node2D.look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("shoot") and shooting == true:
		var bullet = bullet_scene.instance()
		get_parent().add_child(bullet)
		bullet.global_position = $Node2D/Polygon2D.global_position
		bullet.parent = "player"
		get_parent().ammo -= 1
		#bullet.look_at(get_viewport().get_mouse_position())
		bullet.vel = -4*($Node2D.global_position-bullet.global_position)

	if on_ground == true:
		
		velocity = Vector2.ZERO
		if Input.is_action_pressed("left"):
			velocity += transform.y * speed
			left = true

		elif Input.is_action_pressed("right"):
			velocity -= transform.y * speed
			left = false
			

		if Input.is_action_pressed("jump"):
			velocity = Vector2.ZERO
			#auto_jump = false
			
			velocity -= transform.x * (speed+400)

	if on_ground == false:
		
			
		if Input.is_action_pressed("left"):
			velocity += transform.y * (speed/50)
			left = true
	
		elif Input.is_action_pressed("right"):
			velocity -= transform.y * (speed/50)
			left = false
		
		if Input.is_action_just_pressed("stop"):
			velocity = Vector2.ZERO
			

			

		
			

				
func _unhandled_input(event):
	if event is InputEventMouseMotion:
		$Node2D.rotate(-event.relative.x*mouse_sens)
	
func _physics_process(delta):
	get_input()
	#crashed = false
	
	look_at(Vector2(512, 312))
	
	if crashed == true:
		#crashed = false
		
		velocity = Vector2.ZERO
		velocity -= transform.x * (speed+600)
	
	if $RayCast2D.is_colliding():
		var body= $RayCast2D.get_collider()
		if body.is_in_group("planet"):
			on_ground = true
		
	if !$RayCast2D.is_colliding():
		on_ground = false
		
	velocity += transform.x * fall_accl
	move_and_slide(velocity)
	


func _on_KillArea_body_entered(body):
	if body.is_in_group("enemy"):
		lives -= 1
		get_parent().remove_tree = true
		#.
		crashed = true
		$FlyTimer.start()
		#right_kick = true
		#velocity -= transform.x * (speed+400)
		#get_tree().change_scene("res://Scenes/DeathScreen.tscn")
		#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_KillArea2_body_entered(body):
	if body.is_in_group("enemy"):
		get_parent().remove_tree = true
		#.
		$FlyTimer.start()
		crashed = true
		#left_kick = true
		#velocity -= transform.x * (speed+400)
		#get_tree().change_scene("res://Scenes/DeathScreen.tscn")
		#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_FlyTimer_timeout():
	crashed = false
	#print()

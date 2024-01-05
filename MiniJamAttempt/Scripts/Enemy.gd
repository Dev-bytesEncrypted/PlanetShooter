extends KinematicBody2D


var velocity = Vector2()
var speed = 400
var fall_accl = 40
var left = false

var dead = false
var player_pos


var on_ground = false

onready var player = get_parent().get_child(4)
onready var bullet_scene = preload("res://Scenes/Bullet.tscn")

func _physics_process(delta):
	
	if dead == true:
		#get_parent().lives += 1
		get_parent().plant_tree = true
		queue_free()
	velocity = Vector2.ZERO
	

	if get_parent().win == false:
		player_pos = to_local(player.global_position)
		
		#print(player_pos)
		look_at(Vector2(512, 312))
		
		if dead == false:
			if $RayCast2D.is_colliding():
				var body= $RayCast2D.get_collider()
				if body.is_in_group("planet"):
			
			
					if left == false:
						#$Timer.start(0.4)
						velocity += transform.y * speed
						left = false
						
					if left == true:
						#$Timer.start(0.4)
						#yield(get_tree().create_timer(0.4), "timeout")
						velocity -= transform.y * speed
						left = true
					
		
			if !$RayCast2D.is_colliding():
				on_ground = false
				
		#logic of the AI here : 
		#movement logic : 
		
		#print(on_ground)
		#print(dice_jump)
		velocity += transform.x * fall_accl
		move_and_slide(velocity)
	
	else:
		queue_free()


func _on_Area2D_body_entered(body):
	

	if body.is_in_group("player"):
		var bullet = bullet_scene.instance()
		get_parent().call_deferred("add_child", bullet)
		bullet.global_position = $Node2D.global_position
		bullet.speed = -1500
		bullet.parent = "enemy"
		#bullet.vel = $Area2D/CollisionShape2D.global_position - bullet.global_position



func _on_Timer_timeout():
	var rand = RandomNumberGenerator.new()
	rand.randomize()
	
	
	if randi()%2 == 0:
		left = true
	else:
		left = false
		
	$Timer.start(rand.randf_range(0, 2))

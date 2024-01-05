extends Node


#onready var pos_planet = $Planet.global_position
onready var enemy_scene = preload("res://Scenes/Enemy.tscn")
#var lives = 1
onready var deathsceen = preload("res://Scenes/DeathScreen.tscn")
var plant_tree = false
var remove_tree = false
var n = 1
var ammo = 7
var time_taken : float = 0

var win = false

func _ready():
	$CanvasLayer/WIN.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	

func _process(delta):
	
	if win == false:
		time_taken += delta
		$CanvasLayer/LivesNos.text = str(n)
	
	var msec = fmod(time_taken, 1) * 100
	var seconds = fmod(time_taken, 60)
	var minutes = fmod(time_taken, 3600)/60
	
	$CanvasLayer/Min.text = "%02d:"%minutes
	$CanvasLayer/Sec.text = "%02d."%seconds
	$CanvasLayer/Msec.text = "%03d"%msec

		#print("dead")
		
	if Input.is_action_just_pressed("cap"):
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if Input.is_action_just_pressed("visible"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if n >= 24:
		win = true
		#save()
		#$CanvasLayer/LivesNos.text = "24"
		print(time_taken)
		$"/root/HeadL".time.append(time_taken)
		$CanvasLayer/WIN.visible = true
		yield(get_tree().create_timer(2), "timeout")
		get_tree().change_scene("res://Scenes/WinScreen.tscn")
		
	if ammo <= 0:
		remove_tree = true
		ammo = 7
	
	$CanvasLayer/AmmoNos.text = str(ammo)
	if plant_tree == true:
		plant_tree = false
		
		if n < 23:
			$Trees.get_child(n).visible = true
			n += 1
			$Trees.get_child(n).get_child(2).emitting = true
		else:
			$CanvasLayer/LivesNos.text = "24"
			$Trees.get_child(n).visible = true
			$CanvasLayer/WIN.visible = true
			$Player.velocity = Vector2.ZERO
			win = true
			print(time_taken)
			$"/root/HeadL".time.append(time_taken)
			yield(get_tree().create_timer(4), "timeout")
			get_tree().change_scene("res://Scenes/WinScreen.tscn")
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if remove_tree == true:
		remove_tree = false
		
		$Player.get_child(5).emitting = true
		if n > 1 and n < 24:
			n -= 1
			$Trees.get_child(n).visible = false
			
		else:
			#yield(get_tree().create_timer(4), "timeout")
			get_tree().change_scene("res://Scenes/DeathScreen.tscn")
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
func _on_Timer1_timeout():
	var random = RandomNumberGenerator.new()
	random.randomize()
	
	#var spawn_area_decide = random.randi_range(0,1)
	

	
	var x_pos = random.randf_range($SpawnArea.global_position.x - ($SpawnArea/CollisionShape2D.shape.extents.x/2), $SpawnArea.global_position.x + ($SpawnArea/CollisionShape2D.shape.extents.x/2))
	var y_pos = random.randf_range($SpawnArea.global_position.y - ($SpawnArea/CollisionShape2D.shape.extents.y/2), $SpawnArea.global_position.y + ($SpawnArea/CollisionShape2D.shape.extents.y/2))
	
	var time = random.randf_range(5, 10)
	var enemy = enemy_scene.instance()
	add_child(enemy)
	
	enemy.global_position = Vector2(x_pos, y_pos)
	$SpawnArea/Timer1.start(time)
	
	

	

func _on_OrbitalArea_body_exited(body):
	if body.is_in_group("player"):
		remove_tree = true
		body.velocity = Vector2.ZERO


func _on_Timer2_timeout():
	var random = RandomNumberGenerator.new()
	random.randomize()
	
	var x_pos = random.randf_range($SpawnArea2.global_position.x - ($SpawnArea/CollisionShape2D.shape.extents.x/2), $SpawnArea2.global_position.x + ($SpawnArea2/CollisionShape2D.shape.extents.x/2))
	var y_pos = random.randf_range($SpawnArea2.global_position.y - ($SpawnArea/CollisionShape2D.shape.extents.y/2), $SpawnArea2.global_position.y + ($SpawnArea2/CollisionShape2D.shape.extents.y/2))
	
	var time = random.randf_range(5, 10)
	var enemy = enemy_scene.instance()
	add_child(enemy)
	
	enemy.global_position = Vector2(x_pos, y_pos)
	$SpawnArea2/Timer2.start(time)


func _on_AudioTimer1_timeout():
	$AudioStreamPlayer.playing = true

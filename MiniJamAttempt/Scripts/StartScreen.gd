extends Node




func _on_Timer_timeout():
	get_tree().change_scene("res://Scenes/World.tscn")


func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/World.tscn")


func _on_AudioTimer_timeout():
	$AudioStreamPlayer.playing = true

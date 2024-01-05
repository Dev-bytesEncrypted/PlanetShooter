extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _ready():
	$CanvasLayer/Label3.text = str($"/root/HeadL".time.back())
	
	var time_list_max = $"/root/HeadL".time
	
	
	$CanvasLayer/Label5.text = str(time_list_max.min())
func _on_Timer_timeout():
	get_tree().change_scene("res://Scenes/StartScreen.tscn")

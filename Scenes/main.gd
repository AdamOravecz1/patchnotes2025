extends Node

var one = 0

var paused = false

func _ready() -> void:
	get_tree().paused = true
	await get_tree().create_timer(3).timeout
	var tween = create_tween()
	tween.tween_property($CanvasLayer/ColorRect, "modulate", Color(0, 0, 0, 0), 3)
	tween.parallel().tween_property($CanvasLayer/Control, "modulate", Color(0, 0, 0, 0), 3)
	get_tree().paused = false
	$Music.play()


func next_level(number):
	if number == 1 and one == 0:
		one += 1
		$BG/Labels/Welcome.hide()
		$"BG/Labels/1".show()
	elif number == 1 and one == 1:
		one += 1
		$"BG/Labels/1".hide()
		$"BG/Labels/2".show()
	elif number == 1 and one == 2:
		one += 1
		$"BG/Labels/2".hide()
		$"BG/Labels/3".show()
	elif number == 1 and one == 3:
		$"BG/Labels/3".hide()
		$"BG/Labels/4".show()
		
	if number == 2:
		$"BG/Labels/11".show()
		
	if number == 3:
		$"BG/Labels/21".show()
		
	if number == 4:
		$"BG/Labels/31".show()
		
	if number == 5:
		$"BG/Labels/33".show()
	
	if number == 1:
		$Main/Blob.position = Vector2(178, 400)
		


func _on_catcher_body_entered(body: Node2D) -> void:
	print("1")
	$Main/Blob.position = Vector2(5924, 429)


func _on_catcher_2_body_entered(body: Node2D) -> void:
	print("2")
	$Main/Blob.position = Vector2(90, 737)

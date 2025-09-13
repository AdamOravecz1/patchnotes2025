@tool
extends Area2D

@export var number: int = 1:
	set(value):
		number = value
		if Engine.is_editor_hint():
			_update_sprite()

func _ready() -> void:
	
	if Engine.is_editor_hint():
		_update_sprite()
	_update_sprite()

func _update_sprite() -> void:
	if $Throphy:  # make sure noded exists
		$Throphy.frame = number - 1

func _on_body_entered(body: Node2D) -> void:
	if number == 5:
		$BigWin.play()
	else:
		$Win.play()
	get_parent().get_parent().next_level(number)

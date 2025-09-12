extends Node2D

var one = 0
var two = 0
var one_again = false

func next_level(number):
	$BG/Labels/Jump.hide()
	
	if number == 1 and one_again:
		$"BG/Labels/11".hide()
		$"BG/Labels/12".show()
	elif number == 1 and one == 0 and two == 0:
		one += 1
		$BG/Labels/Welcome.hide()
		$"BG/Labels/1".show()
	elif number == 1 and one == 1 and two == 0:
		one += 1
		$"BG/Labels/1".hide()
		$"BG/Labels/2".show()
	elif number == 1 and one == 2 and two == 0:
		#one += 1
		$"BG/Labels/2".hide()
		$"BG/Labels/3".show()
		$BG/Labels/Down1.hide()
		$BG/Labels/Down2.show()
	
	elif number == 2 and one == 0 or one == 1:
		one_again = true
		two += 1
		$BG/Labels/Welcome.hide()
		$"BG/Labels/1".hide()
		$"BG/Labels/11".show()
		
	elif number == 2 and one == 2:
		$"BG/Labels/2".hide()
		$"BG/Labels/3".hide()
		$"BG/Labels/21".show()
		

	$Main/Blob.position = Vector2(-118, 395)

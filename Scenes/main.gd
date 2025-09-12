extends Node

var trophies_picked_up = [0, 0, 0, 0, 0]
var line = [0]

func next_level(number):
	for label in $BG/Labels.get_children():
		label.hide()
		
	trophies_picked_up[number-1] += 1
	print(trophies_picked_up)
	
	if trophies_picked_up[0] == 1 and trophies_picked_up[1] == 0:
		$"BG/Labels/1".show()
	elif trophies_picked_up[0] == 2 and trophies_picked_up[1] == 0:
		$"BG/Labels/2".show()
	elif trophies_picked_up[0] >= 3 and trophies_picked_up[1] == 0:
		$"BG/Labels/3".show()
	elif trophies_picked_up[1] == 1 and trophies_picked_up[0] <= 1 and line[0] == 0:
		line[0] = 1
		trophies_picked_up[0] == 0
		$"BG/Labels/11".show()
	elif trophies_picked_up[1] == 1 and trophies_picked_up[0] > 1 and line[0] == 0:
		$"BG/Labels/21".show()
	elif trophies_picked_up[1] == 1 and trophies_picked_up[0] == 1 and line[0] == 1:
		$"BG/Labels/12".show()
	elif trophies_picked_up[1] == 1 and trophies_picked_up[0] >= 2 and line[0] == 1:
		$"BG/Labels/13".show()
		
	if trophies_picked_up[0] > 1 and trophies_picked_up[1] == 0:
		$BG/EnviromentLabels/Down1.hide()
		$BG/EnviromentLabels/Down2.show()
	if trophies_picked_up[1] > 0:
		$BG/EnviromentLabels/Down1.hide()
		$BG/EnviromentLabels/Down2.hide()
		$BG/EnviromentLabels/Down3.show()
	$Main/Blob.position = Vector2(-118, 395)

class_name SaverLoader extends Node

func save_game(file_num: int):
	var file = FileAccess.open("res://Game/Saves/savegame.data", FileAccess.WRITE)
	
	file.close()
	pass
	
	
func load_game(file_num: int):
	var file = FileAccess.open("res://Game/Saves/savegame.data", FileAccess.READ)

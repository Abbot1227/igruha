extends Resource
class_name Item

@export var icon: Texture2D
@export var name: String

@export_enum("Weapon", "Pickuble")
var type: String = "Weapon"

@export_multiline var description: String


signal item_used

func use_item():
	item_used.emit()

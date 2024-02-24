extends Sprite2D
class_name AbstractItem

var stats: Item = null:
	set(value):
		stats = value
		
		if value != null:
			texture = value.icon
			
func _ready() -> void:
	# testing
	stats = ItemDatabase.get_item("test_poison")

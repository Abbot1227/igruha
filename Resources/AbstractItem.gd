extends Sprite2D

func _ready() -> void:
	var tween: Tween = self.create_tween().set_loops()
	tween.tween_property(self, "position", Vector2(0, -3), 0.8).as_relative()
	tween.tween_property(self, "position", Vector2(0, 3), 0.8).as_relative()

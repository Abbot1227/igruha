extends CharacterBody2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var sprite2: Sprite2D = $Sprite2D2
@onready var anim: AnimationPlayer = $AnimationPlayer2


func take_damage() -> void:
	sprite.hide()
	anim.play("blood")


func on_animation_finished() -> void:
	queue_free()


func _on_hurt_box_area_entered(area):
	if area.is_in_group("weapon"):	
		take_damage()

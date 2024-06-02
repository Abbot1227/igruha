extends CharacterBody2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var sprite2: Sprite2D = $Sprite2D2
@onready var anim = $AnimationPlayer2

func _on_area_2d_area_entered(area):
	sprite.hide()
	anim.play("blood")

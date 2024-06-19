extends Node2D


@onready var interaction_area: InteractionArea = $InteractionArea
@onready var sprite: Sprite2D = $Sprite2D

@export var item_sprite: Resource

func _ready() -> void:
	interaction_area.interact = Callable(self, "_on_interact")
	
	sprite.texture = item_sprite
	
	var tween: Tween = sprite.create_tween().set_loops()
	tween.tween_property(sprite, "position", Vector2(0, -3), 0.8).as_relative()
	tween.tween_property(sprite, "position", Vector2(0, 3), 0.8).as_relative()

func _on_interact() -> void:
	InteractionManager.unregister_area(interaction_area)
	queue_free()

func _on_interaction_area_body_entered(_body):
	sprite.material.set_shader_parameter("enable_outline", true)

func _on_interaction_area_body_exited(_body):
	sprite.material.set_shader_parameter("enable_outline", false)

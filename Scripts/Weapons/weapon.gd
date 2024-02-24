extends Node2D
class_name Weapon

@onready var hitbox: Area2D = $Hitbox
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var weapon_name: String
@export var weight: float
@export_multiline var description: String

func play_atack(direction: Vector2) -> void:
	if !animation_player.is_playing():
		if direction == Vector2.ZERO:
			animation_player.play("attack_left")
			await animation_player.animation_finished
			animation_player.play("idle_left")
		elif direction.y == -1:
			animation_player.play("attack_right")

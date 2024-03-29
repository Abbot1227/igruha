extends CharacterBody2D

var speed = 50
var player_position
var target_position
@onready var player = get_parent().get_node("Player")

func _process(delta):
	player_position = player.position
	target_position = (player_position - position).normalized()

	if position.distance_to(player_position) > 3:
		velocity = target_position * speed
		move_and_slide()

extends Node

const PLAYER = preload("res://Scenes/player.tscn")

var player: CharacterBody2D
var player_spawned: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# Instantiates and adds player to the scene
func add_player_instance() -> void:
	player = PLAYER.instantiate()
	add_child(player)


# Sets global player position
func set_player_position(_new_pos: Vector2):
	player.global_position = _new_pos

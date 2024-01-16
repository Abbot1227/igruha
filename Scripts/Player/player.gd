extends CharacterBody2D

# Max speed the player can go
@export var speed: float = 100
# How quickly player gets max speed
@export var acceleration: float = 10

@onready var anim_sprite: AnimatedSprite2D = $Anim as AnimatedSprite2D

func _physics_process(_delta: float) -> void:
	var direction: Vector2 

func _process(_delta: float) -> void:
	pass

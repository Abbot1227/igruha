class_name Enemy extends CharacterBody2D

signal enemy_damaged()

const DIR4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

@export var hp: int = 1

var direction: Vector2 = Vector2.ZERO
var player: CharacterBody2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var fake_shadow: Sprite2D = $FakeShadow
@onready var hurtbox: Area2D = $HurtBox


func _ready():
	pass
	
	
func _process(delta):
	pass
	

func _physics_process(delta):
	move_and_slide()

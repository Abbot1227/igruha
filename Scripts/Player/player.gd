extends CharacterBody2D


@export var speed: float = 100
var dash_speed: float = speed * 3
const dash_duration: float = 0.2

@onready var animated_sprite: AnimatedSprite2D = $Anim
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var animation_state = animation_tree.get("parameters/playback")
@onready var dash: Node2D = $Dash

func _physics_process(_delta: float) -> void:
	# Move in 4 directions
	var direction: Vector2 = Input.get_vector("left", "right", "up", "down").normalized()
	
	if direction:
		animation_tree.set("parameters/Idle/blend_position", direction)
		animation_tree.set("parameters/Walk/blend_position", direction)
		animation_state.travel("Walk")
		
		# Dash
		if Input.is_action_just_pressed("shift") && dash.can_dash && !dash.is_dashing():
			dash.start_dash(animated_sprite, dash_duration)
		var move_speed: float = dash_speed if dash.is_dashing() else speed
		
		velocity = direction * move_speed
	else:
		animation_state.travel("Idle")
		velocity = Vector2.ZERO
	
	move_and_slide()

func _process(_delta: float) -> void:
	pass

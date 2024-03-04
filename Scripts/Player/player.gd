extends CharacterBody2D


@export var speed: float = 85
var dash_speed: float = speed * 3
const dash_duration: float = 0.2

@onready var animated_sprite: AnimatedSprite2D = $Anim
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var animation_state = animation_tree.get("parameters/playback")
@onready var dash: Node2D = $Dash

enum states {MOVE, JUMP, ATTACK}
var current_state = states.MOVE

var direction: Vector2

func _ready() -> void:
	pass

func _physics_process(_delta: float) -> void:
	match current_state:
		states.MOVE:
			move()
		states.JUMP:
			jump()
		states.ATTACK:
			attack()

func _process(_delta: float) -> void:
	pass

func move() -> void:
	# Get movement direction and normalize it
	direction = Input.get_vector("left", "right", "up", "down").normalized()
	
	# If direction is not Vector2.ZERO
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
	
	if Input.is_action_just_pressed("attack"):
		current_state = states.ATTACK
	
	if Input.is_action_just_pressed("jump") && direction != Vector2.ZERO:
		current_state = states.JUMP
	
	move_and_slide()

func jump() -> void:
	animation_state.travel("Jump")
	velocity = direction * speed
	
	move_and_slide()
	
func attack() -> void:
	var weapon = $Weapon
	weapon.play_atack(direction)
	current_state = states.MOVE

func on_states_reset() -> void:
	current_state = states.MOVE

func clear_collision() -> void:
	$CollisionShape2D.disabled = true

func create_collision() -> void:
	$CollisionShape2D.disabled = false

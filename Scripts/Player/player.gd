extends CharacterBody2D


@export var speed: float = 85
var dash_speed: float = speed * 3
const dash_duration: float = 0.2


@onready var sprite: Sprite2D = $Sprite2D
@onready var shadow_sprite: Sprite2D = $Sprite2D2
@onready var animation_tree: AnimationTree = $AnimationTree
@onready var animation_state = animation_tree.get("parameters/playback")
@onready var dust_particle: GPUParticles2D = $GPUParticles2D
@onready var jump_dust2: Node2D = $Dust2
@onready var jump_dust2_anim: AnimationPlayer = $Dust2/AnimationPlayer

enum states {MOVE, JUMP, ATTACK}
var current_state = states.MOVE

const attack_anims = ["Attack0", "Attack1", "Attack2"]
var random_attack: String

var direction: Vector2

func _ready() -> void:
	pass

func _physics_process(_delta: float) -> void:
	shadow_sprite.frame = sprite.frame
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
	if direction != Vector2.ZERO:
		if sprite.flip_h == true:
			sprite.flip_h = false
		animation_tree.set("parameters/Idle/blend_position", direction)
		animation_tree.set("parameters/Walk/blend_position", direction)
		animation_tree.set("parameters/Jump/blend_position", direction)
		animation_tree.set("parameters/Attack0/blend_position", direction)
		animation_tree.set("parameters/Attack1/blend_position", direction)
		animation_tree.set("parameters/Attack2/blend_position", direction)
			
		animation_state.travel("Walk")
		
		velocity = direction * speed
	else:
		animation_tree.set("parameters/Idle/blend_position", direction)
		animation_state.travel("Idle")
		velocity = Vector2.ZERO
		
	
	if Input.is_action_just_pressed("attack"):
		random_attack = attack_anims[randi() % attack_anims.size()]
		current_state = states.ATTACK
		
	
	if Input.is_action_just_pressed("jump") && direction != Vector2.ZERO:
		current_state = states.JUMP
	
	move_and_slide()
	

func jump() -> void:
	animation_state.travel("Jump")

	velocity = direction * (speed * 1.2)
	
	move_and_slide()
	
	
func attack() -> void:
	animation_state.travel(random_attack)


func on_states_reset() -> void:
	current_state = states.MOVE


func clear_collision() -> void:
	$CollisionShape2D.disabled = true


func create_collision() -> void:
	$CollisionShape2D.disabled = false

	
func on_jump_end() -> void:
	#dust_particle.emitting = true
	jump_dust2.show()
	jump_dust2_anim.play("play")


func reset_dust() -> void:
	jump_dust2.hide()

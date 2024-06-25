extends CharacterBody2D

const SPEED = 50.0

@onready var anim_tree: AnimationTree = $AnimationTree
@onready var anim_state = anim_tree.get("parameters/playback")
@onready var player_detector: Area2D = $PlayerDetector
@onready var player_detector_collider: CollisionShape2D = $PlayerDetector/CollisionShape2D
@onready var state_chart: StateChart = $StateChart
@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D

var player: CharacterBody2D
var direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	await get_tree().process_frame


func _on_player_detector_area_entered(_area):
	state_chart.send_event("player_entered")


func _on_chase_state_entered():
	player = get_parent().find_child("Player")
	nav_agent.target_position = player.global_position


func _on_chase_state_physics_processing(_delta):
	nav_agent.target_position = player.global_position
	
	if !nav_agent.is_target_reached():
		var temp_condition: bool = global_position.direction_to(player.global_position).y > 0 && global_position.distance_squared_to(player.global_position) < 800 && global_position.direction_to(player.global_position).x < 0.5 && global_position.direction_to(player.global_position).x < -0.5
		if temp_condition:
			direction = Vector2.ZERO 
			state_chart.send_event("thrust_attack_ready")
			return
			
		if global_position.distance_squared_to(player.global_position) < 1400:
			direction = Vector2.ZERO
			state_chart.send_event("attack_ready")
			return
			
		if nav_agent.is_target_reachable():
			direction = global_position.direction_to(nav_agent.get_next_path_position())
			velocity = direction * SPEED
			
			anim_tree.set("parameters/Walk/blend_position", direction)
			anim_state.travel("Walk")
			
			move_and_slide()
	#else:
		#direction = Vector2.ZERO
		#state_chart.send_event("attack_ready")


func _on_player_detector_area_exited(_area):
	state_chart.send_event("player_left")


func _on_chase_state_exited():
	# TODO Возможно, возвращать врага в его первоначальную точку
	nav_agent.target_position = position
	direction = Vector2.ZERO


func _on_spin_attack_state_entered():
	direction = global_position.direction_to(player.global_position)
	
	anim_tree.set("parameters/SpinAttack/blend_position", direction)
	anim_state.travel("SpinAttack")


func _on_idle_state_entered():
	anim_state.travel("idle_down")
	player_detector_collider.disabled = true
	player_detector_collider.disabled = false


func _on_thrust_attack_state_entered():
	anim_state.travel("thrust_attack_down")

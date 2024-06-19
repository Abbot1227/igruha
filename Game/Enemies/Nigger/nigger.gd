extends CharacterBody2D

const SPEED = 40.0

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
	nav_agent.target_position = position


func _on_player_detector_area_entered(_area):
	state_chart.send_event("player_entered")


func _on_chase_state_entered():
	player = get_parent().find_child("Player")
	nav_agent.target_position = player.global_position


func _on_chase_state_physics_processing(_delta):
	nav_agent.target_position = player.global_position
	
	if !nav_agent.is_target_reached():
		if nav_agent.is_target_reachable():
			direction = global_position.direction_to(nav_agent.target_position)
			velocity = direction * SPEED
			
			anim_tree.set("parameters/Walk/blend_position", direction)
			anim_state.travel("Walk")
			
			move_and_slide()


func _on_player_detector_area_exited(_area):
	state_chart.send_event("player_left")


func _on_chase_state_exited():
	print("exit")
	player = null
	# TODO Возможно, возвращать врага в его первоначальную точку
	nav_agent.target_position = position
	direction = Vector2.ZERO
	anim_state.travel("idle_down")

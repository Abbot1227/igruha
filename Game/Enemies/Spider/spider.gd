extends CharacterBody2D

const SPEED = 90.0

@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D


func _ready() -> void:
	await get_tree().process_frame
	#set_target_location(Vector2(0.0, 0.0))


func _physics_process(_delta) -> void:
	#var direction = position.direction_to(nav_agent.get_next_path_position())
	#velocity = direction * SPEED
	#nav_agent.velocity = velocity
	
	if nav_agent.is_target_reachable():
		var next_location = nav_agent.target_position
		var direction = global_position.direction_to(next_location)
		#global_position += direction * delta * SPEED
		velocity = direction * SPEED
		move_and_slide()
		
	if Input.is_action_pressed("leftClick"):
		nav_agent.target_position = get_global_mouse_position()


func on_save_game(saved_data: Array[SavedData]):
	var data = SavedData.new()
	data.position = global_position
	data.scene_path = "res://Game/Enemies/Spider/spider.tscn"
	
	saved_data.append(data)


func set_target_location(target: Vector2) -> void:
	nav_agent.target_position = target


func _arrived_at_location() -> bool:
	return nav_agent.is_navigation_finished()

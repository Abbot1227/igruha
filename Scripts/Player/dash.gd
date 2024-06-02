extends Node2D


const dash_delay: float = 0.4
var can_dash: bool = true
var ghost_scene: Resource = preload("res://Scenes/dash_ghost.tscn")
var sprite: Sprite2D

@onready var duration_timer: Timer = $DurationTimer
@onready var ghost_timer: Timer = $GhostTimer

func start_dash(sprite: Sprite2D, duration: float) -> void:
	self.sprite = sprite
	self.sprite.material.set_shader_parameter("whiten", true)
	duration_timer.wait_time = duration
	duration_timer.start()
	ghost_timer.start()
	instantiate_ghost()
	
func end_dash() -> void:
	ghost_timer.stop()
	self.sprite.material.set_shader_parameter("whiten", false)
	can_dash = false
	await get_tree().create_timer(dash_delay).timeout
	can_dash = true

func is_dashing() -> bool:
	return !duration_timer.is_stopped()
	
func instantiate_ghost() -> void:
	var ghost: Sprite2D = ghost_scene.instantiate()
	get_parent().get_parent().add_child(ghost)
	
	ghost.global_position = global_position
	ghost.texture = sprite.texture
	ghost.scale = sprite.scale
	ghost.hframes = sprite.hframes
	ghost.vframes = sprite.vframes
	ghost.frame = sprite.frame

func _on_duration_timer_timeout() -> void:
	end_dash()

func _on_ghost_timer_timeout() -> void:
	instantiate_ghost()

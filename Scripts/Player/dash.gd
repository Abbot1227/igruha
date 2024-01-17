extends Node2D


const dash_delay: float = 0.4
var can_dash: bool = true

@onready var duration_timer: Timer = $DurationTimer

func start_dash(duration: float) -> void:
	duration_timer.wait_time = duration
	duration_timer.start()
	
func end_dash() -> void:
	can_dash = false
	await get_tree().create_timer(dash_delay).timeout
	can_dash = true

func is_dashing() -> bool:
	return !duration_timer.is_stopped()


func _on_duration_timer_timeout() -> void:
	end_dash()

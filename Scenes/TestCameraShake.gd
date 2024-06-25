extends Camera2D

@onready var timer: Timer = $ShakeTimer
@export var amplitude: float = 6.0
@export var duration: float = 0.8
@export var damp_easing: float = 1.0

var shake: bool = false


func _ready() -> void:
	randomize()
	set_process(false)


func _process(_delta) -> void:
	var damping: float = ease(timer.time_left / timer.wait_time, damp_easing)
	offset = Vector2(
		randf_range(amplitude, -amplitude) * damping, 
		randf_range(amplitude, -amplitude) * damping)
	
	
func _on_shake_timer_timeout() -> void:
	shake = false
	
	
func set_shake(shake: bool) -> void:
	self.shake = shake
	set_process(shake)
	offset = Vector2()
	if shake:
		timer.start(duration)


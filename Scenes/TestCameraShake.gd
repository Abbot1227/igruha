extends Camera2D


@export var random_strength: float = 1.0
@export var shake_fade: float = 5.0

var rng = RandomNumberGenerator.new()

var active_shake: bool = false

var shake_strength: float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if active_shake:
		play_shake(delta)
	
	
func apply_shake() -> void:
	shake_strength = random_strength
	
	
func random_offset() -> Vector2:
	return Vector2(rng.randf_range(-shake_strength, shake_strength), rng.randf_range(-shake_strength, shake_strength))


func play_shake(delta) -> void:
	apply_shake()
	
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0, shake_fade * delta)
		
		offset = random_offset()

class_name HurtBox extends Area2D


@export var damage: int = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_entered(area: Area2D) -> void:
	# Add if area can take damage function
	print("hurtbox hits")
	if area is HitBox:
		area.take_damage(damage)

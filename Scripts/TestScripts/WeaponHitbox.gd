extends Area2D

@onready var player_position = $"."
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_body_entered(body):
	print(body.position)
	print(position.distance_to(Vector2.ZERO))
	if body.is_in_group("TestWeaponArea"):
		position = body.position
		print(position.distance_to(player_position.position))

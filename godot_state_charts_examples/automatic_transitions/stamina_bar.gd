extends ProgressBar


@onready var player: CharacterBody2D = $"../.."


func _process(_delta) -> void:
	value = player.stamina

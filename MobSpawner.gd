extends Node2D


@export_file var mob_path

@onready var scene: PackedScene = ResourceLoader.load(mob_path)


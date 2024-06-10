class_name LevelLoader extends Node

signal zone_attached(zone_name)
signal zone_removed(zone_name)

@export var unload_delay: float = 5.0

# Словарь уровней в которых детектор уровней
# игрока находится в данный момент
var active_levels = {}


func _ready():
	for level in get_children():
		if level.get("zone_name") != null:
			level.connect("zone_entered", Callable(self, "on_zone_entered"))
			level.connect("zone_exited", Callable(self, "on_zone_exited"))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


#func load_connected_levels(zone_name: String):
#	var current_zone = get_node(zone_name)
#	
#	for connected_area in current_zone.load_trigger.get_overlapping_areas():
#		var connected_level = connected_area.get_parent()


func on_zone_entered(zone_name, zone_path):
	if active_levels.has(zone_name):
		return
	active_levels[zone_name] = zone_path
	
	# Заменить на background resource loader - нужно
	# продумать как использовать здесь таймер
	
	var loaded_level = ResourceLoader.load(zone_path)
	var level_instance = loaded_level.instantiate()
	
	call_deferred("attach_zone", zone_name, level_instance)
	

func attach_zone(zone_name: String, level_instance):
	get_node(zone_name).add_child(level_instance)
	emit_signal("zone_attached", zone_name)


func on_zone_exited(zone_name):
	active_levels.erase(zone_name)
	get_tree().create_timer(unload_delay).connect("timeout", Callable(self,"remove_zone").bind(zone_name))


func remove_zone(zone_name: String):
	get_node(zone_name).get_child(-1).queue_free()
	emit_signal("zone_removed", zone_name)

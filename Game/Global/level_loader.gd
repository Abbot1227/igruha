class_name LevelLoader extends Node

signal zone_attached(zone_name)
signal zone_removed(zone_name)

# Время после которого уровень вне зоны детекции
# ирока будет удалён из памяти
@export var unload_delay: float = 5.0

# Словарь уровней в которых детектор уровней
# игрока находится в данный момент
var active_levels = {}


func _ready():
	# Соединить сигналы всех зон детекции уровней с методами менеджера уровней
	for level in get_children():
		if level.get("zone_name") != null:
			level.connect("zone_entered", Callable(self, "on_zone_entered"))
			level.connect("zone_exited", Callable(self, "on_zone_exited"))


#func load_connected_levels(zone_name: String):
#	var current_zone = get_node(zone_name)
#	
#	for connected_area in current_zone.load_trigger.get_overlapping_areas():
#		var connected_level = connected_area.get_parent()


# При входе в зону детекции добавить уровень в активные уровни,
# загрузить сцену уровня в кэш и добавить к корневому ноду уровня
func on_zone_entered(zone_name, zone_path):
	if active_levels.has(zone_name):
		return
	active_levels[zone_name] = zone_path
	
	# Заменить на background resource loader - нужно
	# продумать как использовать здесь таймер
	
	var loaded_level = ResourceLoader.load(zone_path)
	var level_instance = loaded_level.instantiate()
	
	# call_deferred во избежание ошибок с загрузкой сцены
	call_deferred("attach_zone", zone_name, level_instance)
	

# Присоединяет сцену уровня к ноду зоны уровня
func attach_zone(zone_name: String, level_instance):
	get_node(zone_name).add_child(level_instance)
	emit_signal("zone_attached", zone_name)


# Удаляет покинутую зону уровня из словаря уровней
# и запускает таймер по истечении которого уровень будет удален
func on_zone_exited(zone_name):
	active_levels.erase(zone_name)
	get_tree().create_timer(unload_delay).connect("timeout", Callable(self,"remove_zone").bind(zone_name))


# Удаляет сцену с уровнем у зоны уровня
# (всегда последняя нода зоны уровня)
func remove_zone(zone_name: String):
	# Если игрок повторно не вошёл в зону детекции уровня,
	# сцена уровня будет удалена
	if active_levels.has(zone_name):
		return
		
	get_node(zone_name).get_child(-1).queue_free()
	emit_signal("zone_removed", zone_name)

@tool
extends Node2D

signal zone_entered(zone_name, zone_path)
signal zone_exited(zone_name)

# Единственный способ указать какая сцена будет использована.
#
# Отредактировать размер collisionShape-а под конкретный уровень,
# а каждая сцена с уровнем в свою очередь содержит всю информацию,
# такую как имя уровня, размер и т.д.
@export_file var zone_path

@export var preview: bool:
	set(new_preview):
		display_preview()
 
var zone_name: String     # Имя ноды с уровнем (не имя уровня) 
var load_trigger          # Нода с областью детекции уровня

var preview_node: Node = null




func _ready():
	zone_name = self.name
	
	# Найти
	for child in get_children():
		if child is Area2D:
			load_trigger = child
			break
			
	assert(load_trigger != null)
	
	load_trigger.connect("area_entered", Callable(self, "on_level_enter"))
	load_trigger.connect("area_exited", Callable(self, "on_level_exit"))


func on_level_enter(_area: Area2D):
	print(zone_name)
	print(zone_path)
	emit_signal("zone_entered", zone_name, zone_path)
	
	
func on_level_exit(_area: Area2D):
	print(zone_name)
	emit_signal("zone_exited", zone_name)


func display_preview():
	if not Engine.is_editor_hint():
		return
		
	if preview_node:
		preview_node.queue_free()
		preview_node = null
		
	if zone_path:
		var scene: PackedScene = ResourceLoader.load(zone_path)
		
		if not scene:
			return
			
		preview_node = scene.instantiate()
		
		add_child(preview_node)

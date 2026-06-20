extends Node2D
class_name Transition

# Название зоны (для отладки)
@export var zone_name: String

# Путь к следующей сцене (можно указать в инспекторе)
@export var next_scene_path: String

func _ready():
	# Передаём данные дочерним узлам
	pass

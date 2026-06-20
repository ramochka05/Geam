extends Area2D

# Путь к следующей сцене (можно указать в инспекторе)
@export var next_scene_path: String

# Название зоны (для отладки)
@export var zone_name: String

var player_is_near = false

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body.is_in_group("player"):
		player_is_near = true
		print("Игрок рядом с зоной: ", zone_name)

func _on_body_exited(body):
	if body.is_in_group("player"):
		player_is_near = false
		print("Игрок покинул зону: ", zone_name)

# Вызывается из скрипта игрока при нажатии клавиши
func interact():
	if player_is_near and next_scene_path != "":
		print("Переход на сцену: ", next_scene_path)
		get_tree().change_scene_to_file(next_scene_path)

extends Area2D

@onready var sprite: Sprite2D = $PNGApple

var is_collected = false # Наш замок


# Флаг, находится ли игрок в зоне
var player_is_near = false

func _ready():
	# Подключаем сигналы области к функциям в этом скрипте
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(_body):
	# Проверяем, что вошел именно игрок (нужно повесить на игрока группу "player")
	player_is_near = true

func _on_body_exited(_body):
	player_is_near = false

# Эта функция будет вызываться из главного скрипта или через Input
func interact():
	if player_is_near:
		if is_collected: 
			return
		
		print("Взаимодействие с предметом!")
		is_collected = true
		print("Яблоко подобрано один раз")
		call_deferred("queue_free")

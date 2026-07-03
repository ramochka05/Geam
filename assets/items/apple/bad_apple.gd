extends Area2D

# Данные для инвентаря
@export var item_data: ItemData
@export var amount: int = 1

@onready var sprite = $PNGApple

var is_collected = false 
var player_node = null

# ВОТ ОНА! Переменная, которую ищет скрипт твоего друга:
var player_is_near = false 

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	# Если у того, кто подошел, есть инвентарь (это игрок)
	if "inventory" in body:
		player_node = body
		player_is_near = true # Даем сигнал скрипту друга, что игрок рядом

func _on_body_exited(body):
	if body == player_node:
		player_node = null
		player_is_near = false

# Эту функцию вызывает скрипт игрока твоего друга при нажатии кнопки Е (или другой)
func interact():
	if is_collected: 
		return
		
	# Проверяем, вставили ли вы ресурс в Инспектор
	if item_data != null:
		print("Подбираем предмет...")
		is_collected = true
		
		# Кладем предмет в инвентарь
		player_node.inventory.add_item(item_data, amount)
		
		# Удаляем яблоко
		call_deferred("queue_free")
	else:
		print("ОШИБКА: Забыли перетащить ресурс ItemData в инспектор!")

extends CharacterBody2D

const SPEED = 300.0
var current_scale = 0.2

@export var drop_scene: PackedScene
@onready var inventory = $Inventory 
@onready var inventory_ui = $InventoryUI 
# Получаем ссылку на узел спрайта (измените имя, если оно другое)
@onready var sprite = $Sprite2D
# Получаем ссылку на форму коллизии
@onready var collision_shape = $Area2D/CollisionShape2D

@onready var interaction_area: Area2D = $Area2D

func _ready():
	
	if GameManager.next_spawn_position != Vector2.ZERO:
		set_global_position(GameManager.next_spawn_position)
		GameManager.next_spawn_position = Vector2.ZERO
	
	
	# ВОТ ЭТО САМОЕ ГЛАВНОЕ: 
	# Соединяем сигнал изменения инвентаря с функцией обновления экрана
	inventory.inventory_changed.connect(inventory_ui.update_ui.bind(inventory.items))
	
	inventory_ui.drop_item_requested.connect(_on_drop_item)
	
	# Обновляем один раз при старте игры
	inventory_ui.update_ui(inventory.items)
	
	
func _physics_process(delta):
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * SPEED
	move_and_slide()
# --- ИЗМЕНЕНИЕ РАЗМЕРА ОТ ПОЗИЦИИ ---
	# Получаем высоту экрана, чтобы узнать, где "дно"
	var screen_size = get_viewport().get_visible_rect().size
	
	# Считаем масштаб: 
	# Чем ближе Y к screen_size.y (низу), тем больше число.
	# clamp() не дает масштабу упасть ниже 0.5 или подняться выше 2.0
	var raw_scale = position.y / screen_size.y
	current_scale = clamp(raw_scale, 0.15, 5.0)
	
	## Применяем масштаб к спрайту или самому телу
	## ВАЖНО: Если у вас есть спрайт внутри тела, используйте $Sprite2D.scale
	## Если вы хотите масштабировать всё тело целиком (включая коллизию), пишите scale
	#sprite.scale = Vector2(current_scale, current_scale)
	#if collision_shape.shape is RectangleShape2D:
		#var base_size = Vector2(150, 350) # Впишите сюда ваш изначальный размер хитбокса
		#collision_shape.shape.size = base_size * current_scale
	
func _input(event):
	# Проверяем, является ли событие нажатием клавиши
	if event is InputEventKey:
		# Проверяем, была ли клавиша нажата (не отпущена)
		if event.pressed:
			match event.keycode:
				KEY_E:   
					print("Клавиша E нажата")
					try_interact()
	
func try_interact():
	# Получаем все Area2D, которые пересекаются с игроком
	if interaction_area != null:
		var areas = interaction_area.get_overlapping_areas()
		for area in areas:
			if area.has_method("interact"):
				# Дополнительно проверяем, что игрок действительно рядом с этим предметом
				if area.player_is_near:
					area.interact()
					return # Взаимодействуем только с одним предметом за раз
					


func _on_bad_apple_player_entered() -> void:
	pass # Replace with function body.
	
	
func _on_drop_item(item_data: ItemData):
	# 1. Удаляем 1 штуку из инвентаря
	inventory.remove_item(item_data, 1)
	
	# 2. Проверяем, есть ли у предмета путь к сцене выброса
	if item_data.drop_scene_path != "":
		# Превращаем текстовый путь в реальную сцену
		var scene_to_drop = load(item_data.drop_scene_path)
		var drop = scene_to_drop.instantiate()
		
		# Передаем данные и ставим на пол
		drop.item_data = item_data 
		drop.global_position = global_position + Vector2(0, 80) 
		get_parent().add_child(drop)
	else:
		print("ОШИБКА: В настройках ресурса " + item_data.name + " не указан путь Drop Scene Path!")

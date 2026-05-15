extends CharacterBody2D

const SPEED = 300.0
var current_scale = 1.0

@onready var inventory = $Inventory 
@onready var inventory_ui = $InventoryUI 
# Получаем ссылку на узел спрайта (измените имя, если оно другое)
@onready var sprite = $Sprite2D
# Получаем ссылку на форму коллизии
@onready var collision_shape = $CollisionShape2D
func _ready():
	# ВОТ ЭТО САМОЕ ГЛАВНОЕ: 
	# Соединяем сигнал изменения инвентаря с функцией обновления экрана
	inventory.inventory_changed.connect(inventory_ui.update_ui.bind(inventory.items))
	
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
	
	# Применяем масштаб к спрайту или самому телу
	# ВАЖНО: Если у вас есть спрайт внутри тела, используйте $Sprite2D.scale
	# Если вы хотите масштабировать всё тело целиком (включая коллизию), пишите scale
	$Sprite2D.scale = Vector2(current_scale, current_scale)
	if collision_shape.shape is RectangleShape2D:
		var base_size = Vector2(150, 350) # Впишите сюда ваш изначальный размер хитбокса
		collision_shape.shape.size = base_size * current_scale

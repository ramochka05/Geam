extends CanvasLayer

@onready var item_list = $ColorRect/ItemList

func _ready():
	# 1. Прячем при старте
	hide()
	
	# 2. Настройки отображения (чтобы текст не обрезался)
	item_list.icon_mode = ItemList.ICON_MODE_TOP
	item_list.fixed_icon_size = Vector2(32, 32)
	item_list.fixed_column_width = 100   # Достаточная ширина
	item_list.max_text_lines = 2         # РАЗРЕШАЕМ 2 СТРОКИ ТЕКСТА
	
	# Убираем лишние отступы и обрезку
	item_list.add_theme_constant_override("v_separation", 2)
	item_list.text_overrun_behavior = TextServer.OVERRUN_NO_TRIMMING

func _process(_delta):
	# 3. ЛОГИКА ОТКРЫТИЯ (Проверь, что эта функция у тебя есть!)
	if Input.is_action_just_pressed("ui_focus_next"): # Это кнопка TAB
		visible = !visible
		if visible:
			print("Инвентарь открыт")
		else:
			print("Инвентарь закрыт")

func update_ui(inventory_items: Array):
	# 4. ОБНОВЛЕНИЕ СПИСКА
	item_list.clear()
	
	for slot in inventory_items:
		var item = slot["item"]
		var amount = slot["amount"]
		
		var display_text = item.name
		if amount > 1:
			display_text += "\nx" + str(amount) # Перенос на новую строку
		
		item_list.add_item(display_text, item.icon)

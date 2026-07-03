extends CanvasLayer

# Создаем сигнал, который скажет игроку: "Эй, я хочу выбросить этот предмет!"
signal drop_item_requested(item_data) 

@onready var item_list = $ColorRect/ItemList
@onready var drop_button = $ColorRect/DropButton

var current_items = []
var selected_index = -1 # Номер выбранного предмета (-1 значит ничего не выбрано)

func _ready():
	hide()
	# --- НАСТРОЙКИ КРАСОТЫ ИНВЕНТАРЯ ---
	# 1. Размер иконки (сделаем аккуратный квадрат 48x48 пикселей)
	item_list.fixed_icon_size = Vector2(48, 48) 
	
	# 2. Текст будет находиться справа от иконки
	item_list.icon_mode = ItemList.ICON_MODE_LEFT
	
	# 3. Делаем колонку широкой (300 пикселей), чтобы текст "Зеленое яблоко (x5)" точно влез
	item_list.fixed_column_width = 300 
	
	# 4. Запрещаем обрезать текст троеточием
	item_list.text_overrun_behavior = TextServer.OVERRUN_NO_TRIMMING
	# -----------------------------------
	
	# Изначально кнопка выброса выключена (пока не кликнем на яблоко)
	drop_button.disabled = true 
	
	# Подключаем сигналы
	item_list.item_selected.connect(_on_item_selected)
	drop_button.pressed.connect(_on_drop_pressed)

func _process(_delta):
	# Открытие на TAB
	if Input.is_action_just_pressed("ui_focus_next"):
		visible = !visible

# Обновление графики
func update_ui(inventory_items: Array):
	current_items = inventory_items
	item_list.clear()
	selected_index = -1
	drop_button.disabled = true # Сбрасываем кнопку при обновлении
	
	for slot in inventory_items:
		var item = slot["item"]
		var amount = slot["amount"]
		var text = item.name
		if amount > 1:
			text += " (x" + str(amount) + ")"
		item_list.add_item(text, item.icon)

# Когда мы кликнули на предмет в списке
func _on_item_selected(index: int):
	selected_index = index
	drop_button.disabled = false # Включаем кнопку!

# Когда нажали "Выбросить"
func _on_drop_pressed():
	if selected_index >= 0:
		# Берем данные выбранного предмета и отправляем сигнал игроку
		var item_to_drop = current_items[selected_index]["item"]
		drop_item_requested.emit(item_to_drop)

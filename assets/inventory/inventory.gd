extends Node
class_name Inventory

signal inventory_changed 

# ВАЖНО: переменная должна быть ВЫШЕ всех функций
var items: Array = []

func _ready():
	items = GlobalInventory.load_data()
	# Даем маленькую задержку перед обновлением UI, чтобы всё успело прогрузиться
	await get_tree().process_frame
	inventory_changed.emit()

func add_item(item: ItemData, amount: int = 1):
	var found_slot = null
	
	if item.is_stackable:
		for slot in items:
			# Сравниваем по имени — это самый надежный способ
			if slot["item"].name == item.name:
				if slot["amount"] < slot["item"].max_stack_size:
					found_slot = slot
					break
	
	if found_slot:
		found_slot["amount"] += amount
	else:
		# Если не нашли стак, создаем новую ячейку
		items.append({"item": item, "amount": amount})
	
	# Сохраняем и обновляем
	GlobalInventory.save_data(items)
	inventory_changed.emit()

# Функция удаления предмета
func remove_item(item: ItemData, amount: int = 1):
	for i in range(items.size()):
		if items[i]["item"].name == item.name:
			items[i]["amount"] -= amount
			
			# Если количество упало до нуля (или ниже) - удаляем ячейку
			if items[i]["amount"] <= 0:
				items.remove_at(i)
				
			# Сохраняем и обновляем
			GlobalInventory.save_data(items)
			inventory_changed.emit()
			return

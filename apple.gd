extends Area2D

@export var item_data: ItemData
@export var amount: int = 1

var is_collected = false # Наш замок

func _on_body_entered(body: Node2D) -> void:
	# Если замок закрыт, игнорируем касание
	if is_collected: 
		return 
	
	if "inventory" in body:
		if item_data != null:
			is_collected = true # СРАЗУ закрываем замок!
			print("Яблоко подобрано один раз")
			body.inventory.add_item(item_data, amount)
			queue_free.call_deferred()

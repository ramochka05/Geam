extends Node

var items: Array = []

func save_data(new_items: Array):
	# .duplicate(true) делает полную копию данных, а не просто ссылку
	items = new_items.duplicate(true)

func load_data() -> Array:
	return items.duplicate(true)

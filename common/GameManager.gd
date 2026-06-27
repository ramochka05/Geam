extends Node

var next_spawn_position: Vector2 = Vector2.ZERO

var collected_items = {}

func collect_item(item_id: String) -> void:
	collected_items[item_id] = true

func has_item(item_id: String) -> bool:
	return collected_items.get(item_id, false)

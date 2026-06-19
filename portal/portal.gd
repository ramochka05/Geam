extends Area2D


@export var scene: String

func _on_body_entered(body: Node2D) -> void:
	var NewScene = load("res://assets/levels/hall/hall.tscn")
	get_tree().change_scene_to_packed(NewScene)

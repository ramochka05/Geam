extends Area2D

@onready var message_label = $MomText
var player_is_near = false

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	message_label.visible = false

func _on_body_entered(_body):
	player_is_near = true

func _on_body_exited(_body):
	player_is_near = false
	message_label.visible = false


func interact() -> void:
	if player_is_near:
		print("Some phrase")
		# Показываем фразу на 2 секунды
		message_label.visible = true
		await get_tree().create_timer(2.0).timeout
		message_label.visible = false

extends Area2D

@onready var message_label = $MomText
var player_is_near = false

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	message_label.visible = false
	
	Dialogic.signal_event.connect(_on_dialogic_signal)

func _on_body_entered(_body):
	player_is_near = true

func _on_body_exited(_body):
	player_is_near = false
	message_label.visible = false


#func interact() -> void: #Старая реализация
#	if player_is_near:
#		print("Some phrase")
#		# Показываем фразу на 2 секунды
#		message_label.visible = true
#		await get_tree().create_timer(2.0).timeout
#		message_label.visible = false

func _on_dialogic_signal(argument):
	if argument == "accept":
		print("Завершено задание")
		QuestManager.complete_quest_by_title("Пойти на кухню")
		print("Получено новое задание")
		QuestManager.add_quest("Принести соль", "По словам Мамы она должна быть где-то...")
	else:
		print("Задание не изменилось")

func interact() -> void: #Новая реализация (с диалоговой системой)
	if player_is_near:
		print("Начинается диалог_1")
		Dialogic.start("timeline_1")
